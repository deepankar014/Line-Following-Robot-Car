// ==========================
// Line Following Robot Car
// 3 IR Sensors + L298N + PWM
// ==========================

/////////////////////////////
// ----- Pin Definitions -----
/////////////////////////////

// Line sensor pins (digital)
const int SENSOR_LEFT   = 2;
const int SENSOR_CENTER = 3;
const int SENSOR_RIGHT  = 4;

// L298N motor driver pins
const int ENA = 5;   // PWM - Left motor speed
const int ENB = 6;   // PWM - Right motor speed
const int IN1 = 8;   // Left motor direction 1
const int IN2 = 9;   // Left motor direction 2
const int IN3 = 10;  // Right motor direction 1
const int IN4 = 11;  // Right motor direction 2;

// ----- Speed Settings -----
const int BASE_SPEED       = 150; // forward normal speed (0–255)
const int TURN_SPEED       = 150; // turning speed (0–255)
const int SLIGHT_TURN_DIFF = 70;  // speed difference for gentle corrections


/////////////////////////////
// ----- Sensor Read -----
/////////////////////////////

// Read sensors and convert to boolean: true = on line, false = off line
void readLineSensors(bool &leftOn, bool &centerOn, bool &rightOn) {
  int leftRaw   = digitalRead(SENSOR_LEFT);
  int centerRaw = digitalRead(SENSOR_CENTER);
  int rightRaw  = digitalRead(SENSOR_RIGHT);

  // Assuming: sensor gives LOW on black line, HIGH on white surface
  leftOn   = (leftRaw   == LOW);
  centerOn = (centerRaw == LOW);
  rightOn  = (rightRaw  == LOW);
}


/////////////////////////////
// ----- Motor Control -----
/////////////////////////////

void stopCar() {
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
  analogWrite(ENA, 0);
  analogWrite(ENB, 0);
}

void moveForward() {
  // Left motor forward
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  // Right motor forward
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);

  analogWrite(ENA, BASE_SPEED);
  analogWrite(ENB, BASE_SPEED);
}

void slightLeft() {
  // Both motors forward but left slower than right
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);

  int leftSpeed  = BASE_SPEED - SLIGHT_TURN_DIFF;
  int rightSpeed = BASE_SPEED + SLIGHT_TURN_DIFF;

  if (leftSpeed < 0) leftSpeed = 0;
  if (rightSpeed > 255) rightSpeed = 255;

  analogWrite(ENA, leftSpeed);
  analogWrite(ENB, rightSpeed);
}

void slightRight() {
  // Both motors forward but right slower than left
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);

  int leftSpeed  = BASE_SPEED + SLIGHT_TURN_DIFF;
  int rightSpeed = BASE_SPEED - SLIGHT_TURN_DIFF;

  if (rightSpeed < 0) rightSpeed = 0;
  if (leftSpeed > 255) leftSpeed = 255;

  analogWrite(ENA, leftSpeed);
  analogWrite(ENB, rightSpeed);
}

void sharpLeft() {
  // On-spot left turn
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);

  analogWrite(ENA, TURN_SPEED);
  analogWrite(ENB, TURN_SPEED);
}

void sharpRight() {
  // On-spot right turn
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);

  analogWrite(ENA, TURN_SPEED);
  analogWrite(ENB, TURN_SPEED);
}


/////////////////////////////
// ----- Setup & Loop -----
/////////////////////////////

void setup() {
  // Motor pins
  pinMode(ENA, OUTPUT);
  pinMode(ENB, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);

  // Sensor pins
  pinMode(SENSOR_LEFT,   INPUT);
  pinMode(SENSOR_CENTER, INPUT);
  pinMode(SENSOR_RIGHT,  INPUT);

  Serial.begin(9600); // for debugging

  stopCar();
  delay(500);
}

void loop() {
  bool leftOn, centerOn, rightOn;
  readLineSensors(leftOn, centerOn, rightOn);

  // Debugging
  Serial.print("L: ");
  Serial.print(leftOn);
  Serial.print(" C: ");
  Serial.print(centerOn);
  Serial.print(" R: ");
  Serial.println(rightOn);

  // Decision logic
  if (centerOn && !leftOn && !rightOn) {
    // Perfectly on line
    moveForward();
  }
  else if (centerOn && leftOn && !rightOn) {
    // Slightly shifted to right → correct left
    slightLeft();
  }
  else if (centerOn && !leftOn && rightOn) {
    // Slightly shifted to left → correct right
    slightRight();
  }
  else if (leftOn && !centerOn && !rightOn) {
    // Only left sees line → strong left
    sharpLeft();
  }
  else if (rightOn && !centerOn && !leftOn) {
    // Only right sees line → strong right
    sharpRight();
  }
  else if (leftOn && centerOn && rightOn) {
    // All sensors on line (junction / wide line)
    moveForward();
  }
  else {
    // Lost the line
    stopCar();
  }

  delay(10); // small delay for stability
}
