final static float MOVE_SPEED = 4;
final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 50;
final static float GRAVITY = .4;
final static float JUMP_SPEED = 8; 

final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 40;

final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;




//declare global variables
Sprite player;
PImage snow, crate, red_brick, brown_brick, gold, spider;
ArrayList<Sprite> platforms;
ArrayList<Sprite> coins;

 Enemy enemy;

float view_x;
float view_y;

//initialize them in setup().
void setup(){
  size(900, 600);
  imageMode(CENTER);
  player = new Sprite("data/Platformer1.png", 0.6);
  
  player.center_x = 500;
  player.center_y = 100;

  platforms = new ArrayList<Sprite>();
  coins = new ArrayList<Sprite>();
   

 
  spider = loadImage("/Users/shahidaaslam/Desktop/Hamza/Processing/Platformer/Game/data/Platformer1.png");
  gold = loadImage("coinImages/gold1.png");
  red_brick = loadImage("data/red_brick.png");
  brown_brick = loadImage("data/brown_brick.png");
  crate = loadImage("data/crate.png");
  snow = loadImage("data/snow.png");
  createPlatforms("data/map.csv");
  
}

// modify and update them in draw().
void draw(){
  background(255);
  scroll();
  
  player.display();
  resolvePlatformCollisions(player, platforms);
  for(Sprite s: platforms) {
    s.display();
  }
    for(Sprite c: coins) {
    c.display();
    ((AnimatedSprite)c).updateAnimation();
    }
    enemy.display();
} 

void scroll() {
  
float right_boundary = view_x + width - RIGHT_MARGIN;
if (player.getRight() > right_boundary) {
    view_x += player.getRight() - right_boundary;
  }

float left_boundary = view_x + LEFT_MARGIN;
if (player.getLeft() < left_boundary) {
    view_x -= left_boundary - player.getLeft();
  }

float bottom_boundary = view_y + height - VERTICAL_MARGIN;
if(player.getBottom() > bottom_boundary) {
    view_y += player.getBottom() - bottom_boundary;
  }
  
float top_boundary = view_y + VERTICAL_MARGIN;
if(player.getTop() < top_boundary){
    view_y -= top_boundary - player.getTop();
  }
  translate(-view_x, -view_y);
}

// returns true if sprite is one a platform.
public boolean isOnPlatforms(Sprite s, ArrayList<Sprite> walls){
  // move down say 5 pixels to ensure the player is on the platform 
  s.center_y += 5;
  // Check if there are any collisions:
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  // if there is a collision then the player is in contact with the a object 
  // restor the sprite to the original position;
  s.center_y += -5;
  // if collisionlist size if not 0, 
  if (col_list.size() > 0) {
    return true;
  }

return false;

}


// Use your previous solutions from the previous lab.

public void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls){
  // add gravity to change_y of sprite
  s.change_y += GRAVITY;
  
  
  // move in y-direction by adding change_y to center_y to update y position.
  s.center_y += s.change_y;
  
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
    if(s.change_y > 0){
      s.setBottom(collided.getTop());
    }
    else if(s.change_y < 0){
      s.setTop(collided.getBottom());
    }
    s.change_y = 0;
  }

  // move in x-direction by adding change_x to center_x to update x position.
  s.center_x += s.change_x;
  
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
    if(s.change_x > 0){
        s.setRight(collided.getLeft());
    }
    else if(s.change_x < 0){
        s.setLeft(collided.getRight());
    }
  }  

}

boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  }
  else{
    return true;
  }
}

public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
    if(checkCollision(s, p))
      collision_list.add(p);
  }
  return collision_list;
}


void createPlatforms(String filename){
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      if(values[col].equals("1")){
        Sprite s = new Sprite(red_brick, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("2")){
        Sprite s = new Sprite(snow, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("3")){
        Sprite s = new Sprite(brown_brick, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("4")){
        Sprite s = new Sprite(crate, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("5")){
        Coin c = new Coin(gold, SPRITE_SCALE);
        c.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        c.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        coins.add(c);
      }
      else if (values[col].equals("6")){
      enemy = new Enemy(spider, SPRITE_SCALE);
      enemy.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
      enemy.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
      }
      
    }
  }
}
 

// called whenever a key is pressed.
void keyPressed(){
  if(keyCode == RIGHT){
    player.change_x = MOVE_SPEED;
  }
  else if(keyCode == LEFT){
    player.change_x = -MOVE_SPEED;
  }
  // add an else if and check if key pressed is 'a' and if sprite is on platforms
  // if true then give the sprite a negative change_y speed(use JUMP_SPEED)
  // defined above
  
  else if(keyCode == UP && isOnPlatforms(player, platforms)) {
    player.change_y = -JUMP_SPEED;
  
  }

}

// called whenever a key is released.
void keyReleased(){
  if(keyCode == RIGHT){
    player.change_x = 0;
  }
  else if(keyCode == LEFT){
    player.change_x = 0;
  }
}
