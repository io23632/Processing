public class AnimatedSprite extends Sprite{
  PImage[] currentImages;
  PImage[] standNeutral;
  PImage[] moveLeft;
  PImage[] moveRight;
  int direction;
  int index;
  // This decides how often you are cycling thorough the images 
  int frame;
  public AnimatedSprite(PImage img, float scale){
  super(img, scale);
  direction = NEUTRAL_FACING;
  index = 0;
  frame = 0;  
  }
  
  public void updateAnimation() {
 // update frame 
 frame++;
 if (frame % 5 == 0) { // This ensures that the image is updated every 5 frames
   selectDirection();
   // select the image array
   selectCurrentImages();
   // go to the next image in array 
   advanceToNextImage();
   
   }
  
  
  }

public void selectDirection(){
  // if change in x is positive then you are facing right: 
  if (change_x > 0) {
      direction = RIGHT_FACING;
    }
    else if (change_x < 0) {
      direction = LEFT_FACING;
    }
    else {
     direction = NEUTRAL_FACING;  
    }
}

public void selectCurrentImages(){
  // If the player is facing right, then the current image should point to the rightimage array 
  
  if(direction == RIGHT_FACING) {
    currentImages = moveRight;
  }
  
   else if(direction == LEFT_FACING) {
    currentImages = moveLeft;
  }
  
   else if(direction == NEUTRAL_FACING) {
    currentImages = standNeutral;
  }
  
 
}


public void advanceToNextImage(){

// Take the current Index and cycle image; 

index++;
// if you have reached the end of the index cycle back:
if (index == currentImages.length) {
index = 0;
}

image = currentImages[index];

}

}
