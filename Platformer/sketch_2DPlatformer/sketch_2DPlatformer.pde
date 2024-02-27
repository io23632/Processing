// declare variables
final static float moveSpeed = 25;
final static float SPRITE_SCALE = 50.0/128; // original image is 120 pixels, here we are scaling it down to 50
final static float SPRITE_SIZE = 50;

Sprite p;
PImage snow, crate, red_brick, brown_brick;
ArrayList<Sprite> platforms; 

//Intialise them in setup: 
void setup() {
  size(900, 700);
  p = new Sprite("Data/Platformer1.png", 0.5, 300,  100);
  platforms = new ArrayList<Sprite>();
  red_brick = loadImage("/Users/shahidaaslam/Desktop/Hamza/Processing/Platformer/sketch_2DPlatformer/Data/CSVLab/data/red_brick.png");
  brown_brick = loadImage("/Users/shahidaaslam/Desktop/Hamza/Processing/Platformer/sketch_2DPlatformer/Data/CSVLab/data/brown_brick.png");
  crate = loadImage("/Users/shahidaaslam/Desktop/Hamza/Processing/Platformer/sketch_2DPlatformer/Data/CSVLab/data/crate.png");
  snow = loadImage("/Users/shahidaaslam/Desktop/Hamza/Processing/Platformer/sketch_2DPlatformer/Data/CSVLab/data/snow.png");
  // Call create platforms 
  createPlatform("/Users/shahidaaslam/Desktop/Hamza/Processing/Platformer/sketch_2DPlatformer/Data/CSVLab/data/map.csv");
}

void draw() {
  
background(255);
p.display();
p.update(0, 0);
  for (Sprite platform : platforms) {
    platform.display();
  }
}

void createPlatform(String filename){

// loadString creates a string of lines 
String[] lines = loadStrings(filename);
for(int row = 0; row < lines.length; row++) {
  String[] values = split(lines[row], ",");
  for(int col = 0; col < values.length; col++) {
    if (values[col].equals("1")) {
        Sprite s = new Sprite(red_brick, SPRITE_SCALE);
        // Here we are calculating the position of the image (e.g. redbrick) depending on where 
        // it is in the csv row and col, so for a red_brick (1) that is three along from the origin point 
        // the the image will be placed at 3 * 50 (pixels) we add this position to the origin which is
        // 50 / 2 = 25 so the center co-ordinate of the origin is 25, 25. 
        s.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
    }
      else if (values[col].equals("2")) {
      Sprite s = new Sprite(brown_brick, SPRITE_SCALE);
       s.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
       else if (values[col].equals("3")) {
      Sprite s = new Sprite(crate, SPRITE_SCALE);
       s.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
       else if (values[col].equals("4")) {
      Sprite s = new Sprite(snow, SPRITE_SCALE);
       s.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
  }
 }
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
