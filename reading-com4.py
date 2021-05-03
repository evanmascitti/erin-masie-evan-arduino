# -*- coding: utf-8 -*-
"""
Created on Thu Apr 22 15:59:06 2021

@author: evanm
"""

# this script opens the COM4 serial port 
# on my laptop to read data from the Arduino
# unit and write to a csv file connection

# It is modified from the solution detailed 
# at https://makersportal.com/blog/2018/2/25/python-datalogger-reading-the-serial-output-from-arduino-to-analyze-data-using-pyserial

import serial
import time
import csv

ser = serial.Serial('COM4', 115200)
ser.flushInput()

while True:
    try:
        ser_bytes = ser.readline()
       
        print(ser_bytes)
        with open("test_data2.csv","a") as f:
            writer = csv.writer(f,delimiter=",")
            writer.writerow([time.time(), ser_bytes])
    except:
        print("Keyboard Interrupt")
        break
