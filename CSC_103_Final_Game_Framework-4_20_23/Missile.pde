
/*
I originally made this class at the beginning of the project but ended up not needing it. I dont know how to get rid of the tab once it has been created.


*/


class Missile{
  
  int x;
  int y;
  int xSpeed;
  int w;
  
    // hitbox vars
  float top;
  float bottom;
  float left;
  float right;
  
  Missile(int startingX , int startingY){
    
    x = startingX;
    y = startingY;
    
    xSpeed = 15;
    w = 50;
   // initialize hitbox vars:
    top = y - w/2;
    bottom = y + w/2;
    left = x - w/2;
    right = x + w/2;
    
  }
  
  void render(){
     fill(0,255,0);
     square(x,y,w);
    
  }
  
 void move(){
     x -= xSpeed;
    // updates hitbox vars:
    top = y - w/2;
    bottom = y + w/2;
    left = x - w/2;
    right = x + w/2;
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
