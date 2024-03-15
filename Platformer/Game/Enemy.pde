public class Enemy extends AnimatedSprite{
  
  public Enemy(PImage img, float scale){
  super(img, scale);
   currentImages = new PImage[1];
   currentImages[0] = loadImage("/Users/shahidaaslam/Desktop/Hamza/Processing/Platformer/Game/data/Platformer1.png");
  }

}
