public class Sprite {

PImage img;

float centerX, centerY;
float changeX, changeY;

float w, h;

// Constructer:
public Sprite(String filename, float scale, float CenterX, float CenterY){
    img = loadImage(filename);
    w = img.width * scale;
    h = img.height * scale;
    this.centerX = CenterX;
    this.centerY = CenterY;
    
}

public Sprite(String filename, float scale) {
 // Using this, I am calling the first constrocter insdie this second constructer, where centerX and centerY are 0;
this(filename, scale, 0, 0);
}



public Sprite(PImage img, float scale){
this.img = img; 
w = img.width * scale;
h = img.height * scale;
centerX = 0;
centerY = 0;
changeX = 0;
changeY = 0;

}

// Method to display image: 
public void display() {
  image(img, centerX, centerY, w, h);
}

// Method to update image position:
public void update(float changeX, float changeY) {
  //this.changeX = changeX;
  //this.changeY = changeY;
  centerX += changeX;
  centerY += changeY;
  }
  

void setLeft(float newleft) {
  centerX = newleft + w/2;
}
float getLeft(){
return centerX - w/2;
}

void setRight(float newright){
centerX = newright - w/2;
}
float getRight(){
return centerX + w/2;
}

void setTop(float newtop){
centerY = newtop + h/2;
}
float getTop(){
return centerY - h/2;
}

void setBottom(float newbottom){
centerY = newbottom - h/2;
}
float getBottom(){
return centerY + h/2;
}
   
}
