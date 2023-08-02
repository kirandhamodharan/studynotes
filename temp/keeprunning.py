#!/usr/bin/python3

import pyautogui
import random
import time

pyautogui.PAUSE = 1.0
pyautogui.FAILSAFE = True
print('Press Ctrl-C to quit')
try:
    while True:
        time.sleep(5)
        width, height = pyautogui.size()
        x = random.randrange(1, width)
        y = random.randrange(1, height)
        pyautogui.moveTo(x,y)
        x,y = pyautogui.position()
        pyautogui.press('ctrl')
        positionStr = 'X:' + str(x).rjust(4) + ' Y:' + str(y).rjust(4)
        print(positionStr, end='')
        print('\b' * len(positionStr), end='', flush=True)
except KeyboardInterrupt:
    print('\nDone')
        
