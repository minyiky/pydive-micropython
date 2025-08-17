'''
A basic example that registers SDL display and input drivers and starts the event loop
'''

import time

import lvgl as lv
from lv_utils import event_loop

lv.init()

el = event_loop()

WIDTH=480
HEIGHT=320

disp_drv = lv.sdl_window_create(WIDTH, HEIGHT)
mouse = lv.sdl_mouse_create()
keyboard = lv.sdl_keyboard_create()
keyboard.set_group(lv.group_create())

while True:
    time.sleep(100)