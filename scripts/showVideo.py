import sys
import os
import psutil
import socket
import numpy as np
import multiprocessing
import time
from multiprocessing import shared_memory, Process, Lock
import pygame as pg
import pygame_widgets
from pygame_widgets.slider import Slider
import math
from pygame._sdl2 import Window
np.set_printoptions(threshold=sys.maxsize)
import cv2
from enum import Enum

MAX_HRES = 4096
MAX_VRES = 4096
DEAFULT_HRES = 1920
DEAFULT_VRES = 1080
MAX_PIXEL_BYTE = 4
BUFFER_SIZE = 9000
lock = Lock()

class PixelFormat(Enum):
    ARGB8888 = 0
    RGB888 = 1
    RGB565 = 2

class Sliders:
    exposure = 0
    r_gain = 0
    g_gain = 0
    b_gain = 0

    def __init__(self, screen, q):
        self.exp_slider = Slider(screen, 100, 100, 400, 20, min=0, max=255, step=1, handleColour=(255,255,255), initial=110)
        self.r_slider = Slider(screen, 100, 150, 400, 20, min=0, max=255, step=1, handleColour=(230,0,0))
        self.g_slider = Slider(screen, 100, 190, 400, 20, min=0, max=255, step=1, handleColour=(0,230,0))
        self.b_slider = Slider(screen, 100, 230, 400, 20, min=0, max=255, step=1, handleColour=(0,0,230))
        self.queue = q

    def updateValues(self):
        e = self.exp_slider.getValue()
        r = self.r_slider.getValue()
        g = self.g_slider.getValue()
        b = self.b_slider.getValue()
        if r != self.r_gain or g != self.g_gain or b != self.b_gain or e != self.exposure:
            self.queue.put((e, r, g, b))
            self.exposure = e
            self.r_gain = r
            self.g_gain = g
            self.b_gain = b

def receiver(q_pingpong, shr):
    HOST = '172.16.100.10'
    PORT = 1235
    PAYLOAD_SIZE = 9000-20-8-8-4
    server_addr = (HOST, PORT)
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.setsockopt(socket.SOL_SOCKET,socket.SO_RCVBUF,16*1024*1024)
    s.bind((HOST, PORT))
    print(f"socket buffer size: {s.getsockopt(socket.SOL_SOCKET,socket.SO_RCVBUF)}")     
    
    frameshr = shared_memory.SharedMemory(name=shr)
    framebuffer = np.ndarray([2, MAX_VRES, MAX_HRES*MAX_PIXEL_BYTE], dtype=np.uint8, buffer=frameshr.buf)
    eth_buffer = np.empty((BUFFER_SIZE), dtype = np.uint8)
    cnt = 0
    pingpong  = 0
    last_print_time = 0
    frame_time_list = [1]*5
    hres = DEAFULT_HRES
    vres = DEAFULT_VRES
    last_frame_time = time.time()
    pixel_fmt = PixelFormat.ARGB8888
    while(1):
        len, addr = s.recvfrom_into(eth_buffer, BUFFER_SIZE)
        header = int.from_bytes(eth_buffer[0:8], "little")
        type = header & 0xFF
        if type == 1 and len > 8:
            payload_len = len - 8
            hres = (header >> 8) & 0xFFFF
            line_idx = (header >> 24) & 0xFFFF
            offset = (header >> 40) & 0xFFFF
            pixel_fmt = PixelFormat((header >> 56) & 0xFF)
            try:
                framebuffer[pingpong, line_idx-1][offset:offset + payload_len] = eth_buffer[8 : 8 + payload_len]
            except Exception as e:
                pass
                # print(e)
                # print(f"offset: {offset}. payload length: {payload_len}")
            finally:
                pass
            cnt += 1
        elif type == 0:
            vres = (header >> 8) & 0xFFFF
            frame_cnt = (header >> 24) & 0xFFFF
            frame_time = time.time()
            frame_time_list[frame_cnt % 5] = frame_time - last_frame_time
            if time.time() - last_print_time > 1:
                print(f"interval of a frame: {(sum(frame_time_list)/5)*1000:.4f}ms. Frame rate: {1000/((sum(frame_time_list)/5)*1000):.2f}fps")
                last_print_time = time.time()
            last_frame_time = frame_time
            new_frame = True
            if pixel_fmt == PixelFormat.RGB888:
                pixel_byte = 3
            elif pixel_fmt == PixelFormat.RGB565:
                pixel_byte = 2
            else:
                pixel_byte = 4
            if cnt / math.ceil(hres*pixel_byte/PAYLOAD_SIZE) != vres:
                new_frame = False
                # print(f"received: {cnt / math.ceil(hres*pixel_byte/PAYLOAD_SIZE) }")
                # print(f"expected: {vres}")
                # print(f"VSYNC received but unexpected number of line. Current line count: {cnt}")
            cnt = 0
            if new_frame:
                q_pingpong.put((pingpong, vres, hres, pixel_fmt))
                pingpong = (pingpong + 1) % 2
        else:
            print(f"unexpected type. Type: {type}, Length: {len}")
    frameshr.close()
    frameshr.unlink()

def transmitter(q_rgb):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    e, r, g, b = [0]*4
    while(1):
        try:
            e, r, g, b = q_rgb.get(block=True, timeout=1)
        except Exception as exc:
            pass
        finally:
            while not q_rgb.empty():
                e, r, g, b = q_rgb.get()
            cmd = bytearray([2,e,r,g,b,0,0,0])
            cmd_padding = cmd.ljust(30-8, b'\0')
            sock.sendto(cmd_padding, ('172.16.100.20', 1236))

def pygameProc(q_pingpong, q_rgb, shr):
    frameshr = shared_memory.SharedMemory(name=shr)
    framebuffer = np.ndarray([2, MAX_VRES, MAX_HRES, MAX_PIXEL_BYTE], dtype=np.uint8, buffer=frameshr.buf)
    hres = DEAFULT_HRES
    vres = DEAFULT_VRES
    pixel_fmt = PixelFormat.ARGB8888
    # initialize pygame
    pg.init()
    pg.display.set_caption('Video Streaming')
    screen = pg.display.set_mode((hres, vres), flags=pg.SCALED|pg.DOUBLEBUF, vsync=1)
    pg.display.set_icon(pg.image.load('icon.jpg'))
    sliders = Sliders(screen, q_rgb)
    surf = pg.Surface((vres, hres))
    print(f"pygame surface size: {surf.get_size()}")
    while(1):
        events = pg.event.get()
        pingpong, new_vres, new_hres, new_pixel_fmt = q_pingpong.get()
        while not q_pingpong.empty():
            pingpong, new_vres, new_hres, new_pixel_fmt = q_pingpong.get()
        if new_pixel_fmt != pixel_fmt:
            print(f"pixel format changed from {pixel_fmt.name} to {new_pixel_fmt.name}")
        pixel_fmt = new_pixel_fmt 
        if pixel_fmt == PixelFormat.ARGB8888:
            cvt_image = framebuffer[pingpong].reshape(MAX_VRES, MAX_HRES, 4)[:vres, :hres, 0:3]
        elif pixel_fmt == PixelFormat.RGB888:
            cvt_image = framebuffer[pingpong].reshape(MAX_VRES, MAX_HRES*4)[:vres, :(hres*3)].reshape(vres, hres, 3)
        elif pixel_fmt == PixelFormat.RGB565:
            cvt_image_565 = framebuffer[pingpong].reshape(MAX_VRES, MAX_HRES * 2, 2)[:vres, :hres, 0:2]
            cvt_image = cv2.cvtColor(cvt_image_565, cv2.COLOR_BGR5652BGR) 
        else:
            print(f"unsupported pixel format: {pixel_fmt}")

        cvt_image = cvt_image.transpose(1, 0, 2)
        surf = pg.surfarray.make_surface(cvt_image).convert()
        if vres != new_vres or hres != new_hres: 
            screen = pg.display.set_mode((new_hres, new_vres), flags=pg.SCALED|pg.DOUBLEBUF, vsync=1)
            sliders = Sliders(screen, q_rgb)
            window = Window.from_display_module()
            window.position = (0,0) # Will place the window around the screen
            print(f"display resize from ({hres} x {vres}) to ({new_hres} x {new_vres})")
            vres = new_vres
            hres = new_hres
        screen.blit(surf, (0, 0))
        sliders.updateValues()
        pygame_widgets.update(events)
        pg.display.flip()
    frameshr.close()
    frameshr.unlink()


def main():
    def create_shared_block():
        image_buf = np.empty([2, MAX_VRES, MAX_HRES, MAX_PIXEL_BYTE]).astype(np.uint8)
        shm = shared_memory.SharedMemory(create=True, size=image_buf.nbytes)
        # # Now create a NumPy array backed by shared memory
        return shm
    
    q_pingpong = multiprocessing.Queue() 
    q_rgb = multiprocessing.Queue() 
    frameshr = create_shared_block()
    t1 = multiprocessing.Process(target=receiver, args=(q_pingpong, frameshr.name), name="ImageReceiver")
    t2 = multiprocessing.Process(target=pygameProc, args=(q_pingpong, q_rgb, frameshr.name), name="pygameProc")
    t3 = multiprocessing.Process(target=transmitter, args=(q_rgb,), name="transmitter")
    t1.start()
    t2.start()
    t3.start()
    while(1):
        time.sleep(1)
    frameshr.close()
    frameshr.unlink()

if __name__ == '__main__':
    main() 