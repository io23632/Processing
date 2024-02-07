float x;
float y;
float speedX;
float speedY;
float diam = 10;
float rectangleSize = 100;
int Score = 0;
PFont f;
int bgCol;

void setup() {
  fullScreen();
  fill(#E51C1C);
  f = createFont("Arial",16,true);
  reset_state();
}

void reset_state() {
x = width/2;
y = height/2;
speedX = random(3, 5);
speedY = random(3, 5);
Score = 0;
bgCol = 0;
}

void draw () { 
background(bgCol);
textFont(f,36);
fill(#FCFCFC);
text("Score    " + Score, width/2, 50);

// The ball
ellipse(x, y, diam, diam);
// Left side of screen
rect(0, 0, 20, height);
// Rectangle that follows mousemovement()
rect(width-20, mouseY-rectangleSize/2, 10, rectangleSize);

x += speedX;
y += speedY;

if (x > width-20 && x < width -10 && y > mouseY-rectangleSize/2 && y < mouseY+rectangleSize/2 ) {
  speedX = speedX * -1;
  x += speedX;
  Score++;
  changeCol();
 
}

if (x < 25) {
  speedX *= -1.1;
  speedY *= 1.1;
  x += speedX;
}

if (y > height || y < 0 ) { 
  
 speedY *= -1; 
  
}

}

void changeCol() {
  
  if (bgCol == color(0)) {
    bgCol = color(#F01872);
  
  }
  
  if (bgCol == color(#F01872)) {
    bgCol = color(#1836F0);
  } 
  else if (bgCol == color(#1836F0)) {
    bgCol = color(#18F0E3);
  }
  else if (bgCol == color(#18F0E3)) {
    bgCol = color(#18F07E);
  }
    else  {
      bgCol = color(#F01872);
    }
  }

void keyPressed () {
reset_state();
}
