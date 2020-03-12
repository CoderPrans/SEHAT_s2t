import RPi.GPIO as GPIO
from time import sleep

GPIO.setmode(GPIO.BOARD)

Motor1_1 = 16    # Input Pin
Motor1_2 = 18    # Input Pin
Motor1_3 = 22    # Enable Pin

Motor2_1 = 13    # Input Pin
Motor2_2 = 15    # Input Pin
Motor2_3 = 11    # Enable Pin

# Motor 1 setup out
GPIO.setup(Motor1_1,GPIO.OUT)
GPIO.setup(Motor1_2,GPIO.OUT)
GPIO.setup(Motor1_3,GPIO.OUT)

# Motor 2 setup out
GPIO.setup(Motor2_1,GPIO.OUT)
GPIO.setup(Motor2_2,GPIO.OUT)
GPIO.setup(Motor2_3,GPIO.OUT)

print("FORWARD MOTION")
GPIO.output(Motor1_1,GPIO.HIGH)
GPIO.output(Motor1_2,GPIO.LOW)
GPIO.output(Motor1_3,GPIO.HIGH)

GPIO.output(Motor2_1,GPIO.HIGH)
GPIO.output(Motor2_2,GPIO.LOW)
GPIO.output(Motor2_3,GPIO.HIGH)

sleep(3)

print("STOP")
GPIO.output(Motor1_3,GPIO.LOW)
GPIO.output(Motor2_3,GPIO.LOW)

GPIO.cleanup()
