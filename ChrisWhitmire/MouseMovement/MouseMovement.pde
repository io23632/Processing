// Setup and Draw: 


// Variables are declared outside the set up 
// but inilised in the set up 
/*

Setup is run once to initilise everything at the start of the code
In pong e.g. this would be to set the inital score to 0 / 0 

Draw is run on a loop and in our pong example can be used to : 

Control movement of the ball 
Get constant input from the user to move the rectangle 
*/

int Cx;
int Cy;
int Cd;
int fillparm1;
int fillparm2;
int fillparm3;

void setup() {
background(45);
size(800,400);
Cx = 50;
Cy = 50;
Cd = 100;
fillparm1 = 500;
fillparm2 = 100;
fillparm3 = 250;
//noLoop();
}

void draw() {
background(#FAF7F8);
circle(mouseX, mouseY, Cd);
fill(#15E373);
}

void mousePressed() {
  loop();  // Holding down the mouse activates looping
}

void mouseReleased() {
  noLoop();  // Releasing the mouse stops looping draw()
}
