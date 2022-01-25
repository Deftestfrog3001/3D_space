import java.awt.Robot;

Robot rbt;

boolean wkey, akey, skey, dkey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ;
float leftRightHeadAngle, upDownHeadAngle;

void setup() {
  size(displayWidth, displayHeight, P3D);
  textureMode(NORMAL);
  //noCursor();
  skey = akey = skey = dkey = false;
  eyeX = width/2;
  eyeY = height/2;
  eyeZ = 0;
  focusX = width/2;
  focusY = height/2;
  focusZ = 10;
  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;
  leftRightHeadAngle = radians(270);
  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  background(0);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  drawFloor();
  drawFocalPoint();
  controlCam();
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  box(5);
  popMatrix();
}

void drawFloor() {
  //stroke(#ff00ff);
  for (int x = -10000; x <= 10000; x = x + 100) {
    stroke(#00ff00);
    line(x, height, -10000, x, height, 10000);
    stroke(#0000ff);
    line(-10000, height, x, 10000, height, x);
  }
}

void controlCam() {
  if (wkey) {
    eyeX = eyeX + cos(leftRightHeadAngle)*20;
    eyeZ = eyeZ + sin(leftRightHeadAngle)*20;
  }
  if (skey) {
    eyeX = eyeX - cos(leftRightHeadAngle)*20;
    eyeZ = eyeZ - sin(leftRightHeadAngle)*20;
  }

  if (akey) {
    eyeX = eyeX - cos(leftRightHeadAngle + PI/2)*20;
    eyeZ = eyeZ - sin(leftRightHeadAngle + PI/2)*20;
  }

  if (dkey) {
    eyeX = eyeX + cos(leftRightHeadAngle + PI/2)*20;
    eyeZ = eyeZ + sin(leftRightHeadAngle + PI/2)*20;
  }

  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.005;
  upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.005;
  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle > -PI/2.5) upDownHeadAngle = -PI/2.5;

  focusX = eyeX + cos(leftRightHeadAngle)*300;
  focusZ = eyeZ + sin(leftRightHeadAngle)*300;
  focusY = eyeY + tan(upDownHeadAngle)*300;

  if (mouseX > width-2) rbt.mouseMove(3,mouseY);
  else if (mouseX < 2)  rbt.mouseMove(width-3, mouseY);
}

void keyPressed() {
  if (key == 'W' || key == 'w') wkey = true;
  if (key == 'A' || key == 'a') akey = true;
  if (key == 'S' || key == 's') skey = true;
  if (key == 'D' || key == 'd') dkey = true;
}

void keyReleased() {
  if (key == 'W' || key == 'w') wkey = false;
  if (key == 'A' || key == 'a') akey = false;
  if (key == 'S' || key == 's') skey = false;
  if (key == 'D' || key == 'd') dkey = false;
}
