

////// Create a single custome shape: 
//void setup() {
//  size (800, 400);
//}

//void draw() {
//background(255); // Colour the background white
////BegindShape:
//beginShape();
////Specify the vertex co-ordinates of the custome shape you want to draw: 
//vertex(300,100);
//vertex(350, 150);
//vertex(200, 200);
//vertex(100,100);
//endShape(CLOSE);
//}

//////// Store multiple custom shapes: 
PShape p;
void setup() {
size (800, 400);
background(255);
// intialise the shape: 
p = createShape();
p.beginShape();
vertex(300,100);
vertex(350, 150);
vertex(200, 200);
vertex(100,100);
p.endShape(CLOSE);
}

void draw() {
shape(p, width/2, height/2);
ellipse(100, 100, 100, 100);
}
