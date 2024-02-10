// declare variables
final static float moveSpeed = 25;

Sprite p;


//Intialise them in setup: 
void setup() {
  size(900, 700);
  p = new Sprite("Data/Platformer1.png", 0.5, 300,  100); 
}

void draw() {
  
background(255);
p.display();
p.update(0, 0);

}


void keyPressed() {

  if (keyCode == RIGHT) {
    p.update(moveSpeed, 0);
  }
  else if (keyCode == LEFT) {
    p.update(-moveSpeed, 0);
  }
  else if (keyCode == UP) {
    p.update(0, -moveSpeed);
  }
  else if (keyCode == DOWN) {
    p.update(0, moveSpeed);
  }
  
  
 
}


void keyReleased() {
  
 if (keyCode == RIGHT) {
    p.update(0, 0);
  }
  else if (keyCode == LEFT) {
    p.update(0, 0);
  }
  else if (keyCode == UP) {
    p.update(0, 0);
  }
  else if (keyCode == DOWN) {
    p.update(0, 0);
  }

}
