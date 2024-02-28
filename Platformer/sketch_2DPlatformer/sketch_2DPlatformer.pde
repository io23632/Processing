// declare variables
final static float moveSpeed = 25;
final static float SPRITE_SCALE = 50.0/128; // original image is 120 pixels, here we are scaling it down to 50
final static float SPRITE_SIZE = 50;
final static float GRAVITY = .4;


Sprite player;
PImage snow, crate, red_brick, brown_brick;
ArrayList<Sprite> platforms; 

//Intialise them in setup: 
void setup() {
  size(900, 700);
  imageMode(CENTER);
  player = new Sprite("Data/Platformer1.png", 0.6, 400, 200);
  platforms = new ArrayList<Sprite>();
  
  
  red_brick = loadImage("Data/red_brick.png");
  brown_brick = loadImage("Data/brown_brick.png");
  crate = loadImage("Data/crate.png");
  snow = loadImage("Data/snow.png");
  // Call create platforms 
  createPlatform("Data/map.csv");
}

void draw() {
background(255);

player.display();

resolvePlatformCollisions(player, platforms);

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





/*
Collision detection ; returns a boolean of two sprites are colliding or not
When are the sprites NOT colliding?
case 1: s1 right <= s2 left [Sprite1(]) ([)Sprite]
case 2: s1 left >= s2 right [Sprite2(]) ([)Sprite1]
case 3: s1 bottom < s2 top i.e. S1 is onto of s2 (less than (<) eventhouth S1 is on top 
becasue the y axis is inverted in processing
case4 : s1 top > s2 bottom i.e S1 is below S2       
*/

boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  }
  
 return true;
  
}


/*
CheckcollisionList: 
Given a Sprite and ArrayList of Sprites, return an ArrayList of Sprites whcih collide with the given
Sprite.
This function will return an ArrayList that will check the collision of one sprite
e.g. an enemy or the character and check it against a list of sprites such as coins, 
Why an array list? becuase a character can interact with multiple coins at the same time 
Also, example if your character can shoot bullets, if you want an array list of bullets so you 
can check which of the bullets collide with the enemies. 
*/
public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
    if(checkCollision(s, p))
      collision_list.add(p);
  }
  return collision_list;
}

//public void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls){
//    // Add gravity to changeY:
//    s.changeY += GRAVITY;

//    // Move in the y-direction then resolve collision
//    s.centerY += s.changeY;

//    // Check for collisions in the y direction
//    ArrayList<Sprite> collision_list = checkCollisionList(s, walls);

//    if (collision_list.size() > 0) {
//        Sprite collided = collision_list.get(0);
//        if (s.changeY > 0) { // Falling down
//            s.setBottom(collided.getTop());
//            s.changeY = 0; // Stop vertical movement
//        } else if (s.changeY < 0) { // Moving up, reset vertical speed but don't automatically place on top
//            s.setTop(collided.getBottom());
//            s.changeY = 0; // Stop vertical movement
//        }
//    }

//     //Resolve horizontal movements and collisions similarly to before
//    s.centerX += s.changeX;
//    collision_list = checkCollisionList(s, walls);

//    if (collision_list.size() > 0) {
//        Sprite collided = collision_list.get(0);
//        if (s.changeX > 0) { // Moving right
//            //s.setRight(collided.getLeft());
//        } else if (s.changeX < 0) { // Moving left
//            s.setLeft(collided.getRight());
//        }
//        s.changeX = 0; // Optionally reset horizontal speed
//    }
    
    
//}


public void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls){
  // add gravity to change_y of sprite
  s.changeY += GRAVITY;
  
  
  // move in y-direction by adding change_y to center_y to update y position.
  s.centerY += s.changeY;
 
  // Now resolve any collision in the y-direction:
  // compute collision_list between sprite and walls(platforms).
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  
  /* if collision list is nonempty:
       get the first platform from collision list
       if sprite is moving down(change_y > 0)
         set bottom of sprite to equal top of platform
       else if sprite is moving up
         set top of sprite to equal bottom of platform
       set sprite's change_y to 0
  */
  if(col_list.size() > 0){
    Sprite collided = col_list.get(0);
    if(s.changeY > 0){
      s.setBottom(collided.getTop());
    }
    else if(s.changeY < 0){
      s.setTop(collided.getBottom());
    }
    s.changeY = 0;
  }

  // move in x-direction by adding change_x to center_x to update x position.
  s.centerX += s.changeX;
  
  // Now resolve any collision in the x-direction:
  // compute collision_list between sprite and walls(platforms).   
  col_list = checkCollisionList(s, walls);

  /* if collision list is nonempty:
       get the first platform from collision list
       if sprite is moving right
         set right side of sprite to equal left side of platform
       else if sprite is moving left
         set left side of sprite to equal right side of platform
  */

  if(col_list.size() > 0){
    Sprite collided = col_list.get(0);
    if(s.changeX > 0){
        s.setRight(collided.getLeft());
    }
    else if(s.changeX < 0){
        s.setLeft(collided.getRight());
    }
  }  

}









void keyPressed() {

  if (keyCode == RIGHT) {
    player.update(moveSpeed, 0);
  }
  else if (keyCode == LEFT) {
    player.update(-moveSpeed, 0);
  }
  else if (keyCode == UP) {
    player.update(0, -moveSpeed);
  }
  else if (keyCode == DOWN) {
    player.update(0, moveSpeed);
  }
  
  
 
}


void keyReleased() {
  
 if (keyCode == RIGHT) {
    player.update(0, 0);
  }
  else if (keyCode == LEFT) {
    player.update(0, 0);
  }
  else if (keyCode == UP) {
    player.update(0, 0);
  }
  else if (keyCode == DOWN) {
    player.update(0, 0);
  }

}
