float angle1 = 0;
float angle2 = 0;
float c = 0;
float x = 10;

CameraControl control; // カメラ操作

void setup() {
  size(800, 600, P3D);
  control = new CameraControl(this);
}

void draw() {
  background(100);
  
   if(keyPressed){
     if(key == '1'){
       angle1 = angle1 + x * (1.0 + c);
     }
     if(key == '2'){
       angle1 = angle1 - 1.0;
     }
     if(key == '1'){
       angle2 = angle2 - x * (1.0 + c);
     }
     if(key == '2'){
       angle2 = angle2 + 1.0;
     }
   }
   if(angle1 >= 20){
     c = c -2.0;
     angle1 = angle1 - 1.0;
   }
   if(angle1 <= -20){
     c = 0;
     angle1 = angle1 + 1.0;
   }

  // 箱
  perspective();
  translate( width/2, height/2, 0 );
  rotateX(-PI/2);
  rotateZ(-PI/2);
  fill(211, 116, 68);
  box(100, 100, 100);

  pushMatrix();
  translate(0, -125, 0);
  box(100, 150, 50);
  popMatrix();
  
  pushMatrix();
  translate(-50, -80, -25);
  rotateX(radians(angle1));
  translate(0, 0, 75);
  box(50, 50, 50);
  translate(0, 0, 75);
  rotateX(radians(2 * angle1));
  box(50, 50, 100);
  popMatrix();

  pushMatrix();
  translate(50, -80, -25);
  rotateX(radians(angle1));
  translate(0, 0, 75);
  box(50, 50, 50);
  translate(0, 0, 75);
  rotateX(radians(2 * angle1));
  box(50, 50, 100);
  popMatrix();

  pushMatrix();
  translate(-50, -175, -25);
  rotateX(radians(angle2));
  translate(0, 0, 75);
  box(50, 50, 50);
  translate(0, 0, 75);
  rotateX(radians(2 * angle2));
  box(50, 50, 100);
  popMatrix();

  pushMatrix();
  translate(50, -175, -25);
  rotateX(radians(angle2));
  translate(0, 0, 75);
  box(50, 50, 50);
  translate(0, 0, 75);
  rotateX(radians(2 * angle2));
  box(50, 50, 100);
  popMatrix();
