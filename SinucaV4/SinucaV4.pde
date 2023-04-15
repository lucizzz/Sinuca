 
int numBalls = 5;
float spring = 1;
float gravity = 0;
float friction = -0.9;



Ball[] balls = new Ball[numBalls];

void setup() {
  size(1000, 800);
    for (int i = 0; i < numBalls-1; i++) {
    balls[i] = new Ball(100+(i*100), 100+(i*100), 50, i, balls, 0, 0);
    if (i == numBalls-2){
      i++;
      balls[i] = new Ball(width/2, height/2, 50, i, balls, 0, 0);
      
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

    // A vector that points to the mouse location
    PVector mouse = new PVector(mouseX,mouseY);
    // A vector that points to the center of the window
    PVector center = new PVector(balls[balls.length-1].x, balls[balls.length-1].y);
    // Subtract center from mouse which results in a vector that points from center to mouse
    mouse.sub(center);
    
    // Normalize the vector
    mouse.normalize();
    
    // Multiply its length by 150 (Scaling its length)
    mouse.mult(150);
  
    translate(balls[balls.length-1].x + 35 , balls[balls.length-1].y);
    // Draw the resulting vector
    stroke(255);
    strokeWeight(4);
    line(0,0,mouse.x,mouse.y);
    
    if (mousePressed == true){
      //println("  : "+mouseX);
      
      balls[balls.length-1].vx = -2.3;
      balls[balls.length-1].vy = -2;
    
  }
    
    
    
 
  
}


//void mousePressed(){
//      println("djaiso");
    
//    }



class Ball {
  
  float fat = 0.3;
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin, float vxa, float vya) {
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
    
    //if(vx > 0 || vy > 0){
     // vx -= fat;
     // vy -= fat;
    //}
    
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
