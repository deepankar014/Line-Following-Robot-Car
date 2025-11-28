# 🚗 Line Following Robot Car

An autonomous robotic vehicle capable of accurately following a predefined line path using IR sensors and intelligent motor control. This project showcases the practical implementation of sensor-based navigation using Arduino and demonstrates core robotics concepts such as feedback control, real-time decision making, and embedded system integration.

---

## 📌 Project Overview

The Line Following Robot Car uses **IR Line Sensors** to detect the contrast between a guiding line (typically black tape) and the surrounding surface. The sensor data is processed by the **Arduino Uno**, which decides the movement of the robot in real-time. The motors are controlled via the **L298N motor driver**, allowing the robot to adjust its direction smoothly and remain on track.

This project is ideal for understanding the fundamentals of robotics, automation, and sensor interfacing.

---

## 🎯 Features

* Fully autonomous line-following capability
* Real-time path correction
* Smooth left and right turning
* Modular and scalable design
* Low-cost implementation
* Beginner-friendly yet extensible for advanced control

---

## 🧠 Working Principle

1. IR sensors continuously scan the surface underneath.
2. The sensors differentiate between the line and background based on reflectivity.
3. Arduino reads sensor outputs and determines robot movement:

   * Center sensor detects line → move forward
   * Left sensor detects line → turn left
   * Right sensor detects line → turn right
4. L298N motor driver executes the motion commands by controlling the motors.
5. The process repeats continuously, enabling smooth line tracking.

---

## 🔧 Components Used

### Core Components

* Arduino Uno Rev 3
* L298N Motor Driver Module
* IR Line Sensors (2 or 3 Modules)
* 2 × DC Motors (or 4 for 4WD)
* Robot Chassis
* Wheels

### Power Supply

* 9V / 12V Battery Pack
* Battery Holder
* On/Off Switch

### Additional Components

* Jumper Wires (Male-Male / Male-Female)
* Mounting Screws & Standoffs
* Breadboard (Optional)
* Cable Ties

---

## ⚙️ Hardware Connections

### IR Sensors

For a 3-sensor setup:

* Left Sensor → Arduino Digital Pin
* Center Sensor → Arduino Digital Pin
* Right Sensor → Arduino Digital Pin
* VCC → 5V
* GND → GND

Typical Output Logic:

* Black Line → LOW
* White Surface → HIGH

### Motor Driver (L298N)

* IN1, IN2 → Left Motor control
* IN3, IN4 → Right Motor control
* ENA, ENB → Arduino PWM pins (Speed Control)
* OUT1, OUT2 → Left Motor
* OUT3, OUT4 → Right Motor
* 12V → Battery Positive
* GND → Battery Negative & Arduino GND

---

## 🔁 Control Algorithm

Sensor Pattern (L - C - R):

| Left | Center | Right | Movement Action |
| ---- | ------ | ----- | --------------- |
| 0    | 1      | 0     | Move Forward    |
| 1    | 0      | 0     | Turn Left       |
| 0    | 0      | 1     | Turn Right      |
| 1    | 1      | 0     | Sharp Left      |
| 0    | 1      | 1     | Sharp Right     |
| 0    | 0      | 0     | Stop / Search   |

---

## 💻 Software Requirements

* Arduino IDE
* Arduino Uno Board Package
* Basic knowledge of embedded C / Arduino programming

---

## 📂 Project Structure

```
Line-Following-Robot/
│
├── Code/
│   └── line_following.ino
├── Circuit Diagram/
│   └── circuit_diagram.png
├── Images/
│   ├── robot_front.jpg
│   ├── sensor_mount.jpg
│   └── working_demo.jpg
└── README.md
```

---

## 🚀 How to Run the Project

1. Assemble the robot chassis and mount motors securely.
2. Place IR sensors at the front underside close to the ground.
3. Complete all wiring connections as per diagram.
4. Upload the Arduino sketch using Arduino IDE.
5. Place the robot on the track and switch ON the power.
6. The robot will detect and follow the line automatically.

---

## 🔧 Calibration Tips

* Adjust IR sensor sensitivity using onboard potentiometers.
* Keep sensors 1–2 cm above the ground.
* Use matte black tape for better contrast.
* Tune motor speed to prevent overshooting.

---

## ✅ Applications

* Line-following competitions
* Automated guided vehicles (AGVs)
* Educational robotics projects
* Industrial prototype systems

---

## 🔮 Future Enhancements

* PID control for smoother movement
* Advanced sensor arrays (5 or more sensors)
* Bluetooth/WiFi-based remote monitoring
* Obstacle avoidance + line following hybrid mode
* Speed variation on curves

---

## 🧪 Project Outcome

This project successfully demonstrates a reliable and accurate line-following robot capable of navigating along predefined paths with minimal deviation, proving effective integration of sensing, processing, and actuation systems.

---

## 👨‍💻 Made By

Deepankar Majee

Electronics and Communication Engineering, GEC Gandhinagar

Focus Areas: DIgital Electronics, Embedded Systems, VLSI, Digital Design, and ASIC Flow

---


