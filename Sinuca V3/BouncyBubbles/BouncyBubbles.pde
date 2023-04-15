/**
 * Bouncy Bubbles  
 * based on code from Keith Peters. 
 * 
 * Multiple-object collision.
 */
 
 
int numBalls = 5;
float spring = 1;
float gravity = 0;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];

void setup() {
  size(640, 360);
    for (int i = 0; i < numBalls-1; i++) {
    balls[i] = new Ball(100+(i*100), 100+(i*100), 50, i, balls, 0, 0);
    if (i == numBalls-2){
      println("i: "+i);
      i++;
      balls[i] = new Ball(width/2, height/2, 50, i, balls, -2, -2);
      
    }
    
    
    //balls[balls.length-1].vx=-2; //bola oiginal
    //balls[balls.length-1].vy=-1; //bola oiginal
    
    }
  noStroke();
  fill(255, 204);
}

void draw() {
  background(0);
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();  
  }
}

class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin, float vxa, float vya) {
    println("vx, idin: "+vx+" "+idin);
    println("vy, idin: "+vy+" "+idin);
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
    vx=vxa;
    vy=vya;
  } 
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  
  void move() {
    vx += gravity;
    x += vx;
    y += vy;
    
    //balls[balls.length-1].vx=-2; //bola oiginal
    //balls[balls.length-1].vy=-1; //bola oiginal
    
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
