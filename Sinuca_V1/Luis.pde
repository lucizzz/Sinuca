/**
 * Bounce. 
 * 
 * When the shape hits the edge of the window, it reverses its direction. 
 */
 
float spring = 0.05;
float gravity = 0;
float friction = -0.9;
 
 
 
 
 
int rad = 60;        // Width of the shape
float xpos, ypos;    // Starting position of shape    

float xspeed = 5.8;  // Speed of the shape
float yspeed = 5.2;  // Speed of the shape

float foo = 0;

float xdirection = -1;  // Left or Right
float ydirection = -1;  // Top to Bottom

float fat = 0;

int numBalls = 5;


Ball[] balls = new Ball[numBalls];



void setup() 
{
  size(640, 360);
  noStroke();
  frameRate(30);
  ellipseMode(RADIUS);
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;
    for (int i = 0; i < numBalls-1; i++) {
    balls[i] = new Ball(100+(i*100), 100+(i*100), 50, i, balls);
    println("i fora do if: "+i);
    if (i == numBalls-2){
      
      balls[i+1] = new Ball(width/2, height/2, 50, i, balls);
      println("Aqui "+i);
      
    }
  }
  

}

void draw() 
{
  background(102);
  
  for (Ball xxx : balls) {
    xxx.collide();
    xxx.display();  
  }
  
  // Update the position of the shape
  
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-rad || xpos < rad) {
    xdirection *= -1;
  }
  if (ypos > height-rad || ypos < rad) {
    ydirection *= -1;
  }

  // Draw the shape
  //ellipse(xpos, ypos, rad, rad);
  
  
    
  fat = fat + 0.0002;
    
  if (xspeed > 0 || yspeed > 0){
    xspeed = xspeed - fat;
    yspeed = yspeed - fat;
   }
   if (xspeed < 0){
     xspeed = 0;
   }
   if (yspeed < 0){
     yspeed = 0;
   }
   
   //println(xspeed);
   //println(yspeed);
  
  //delay(500);

}
