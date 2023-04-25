class Player {
  /*
  Class variables
   */
  color fillColor;

  int playerSpeed = 15;

  // player size
  int playerWidth = 20;
  int playerHeight = 20;
  // player 1 position
  int x;
  int y;
  int d;

  // hitbox vars
  float top;
  float bottom;
  float left;
  float right;

  // player 1 move booleans
  boolean p1Up;
  boolean p1Down;
  boolean p1Right;
  boolean p1Left;


  int healthNumber;

  boolean beenHit;
  boolean isDead;
  
  Animation animation;



  /*
  Constructor
   */

  Player(int startingX, int startingY, Animation startingAnimation, int startingHealthNumber) {
    // initialize hitbox vars:


    d = 50;

    healthNumber = startingHealthNumber;

    // initializing player vars:

    x = startingX;
    y = startingY;

    fillColor = color(0, 0, 255);

    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;

    p1Up = false;
    p1Down = false;
    p1Right = false;
    p1Left = false;


    beenHit = false;
    animation = startingAnimation;
    isDead = false;
  }

  void render() {
   // fill(fillColor);
     
    if(!keyPressed || key == ' ' ){
      XwingAnimation.display(x, y);
        XwingAnimation.isAnimating = true; 
    }
    else if(playerUp == true){
      XwingAnimationUp.display(x, y);
       XwingAnimationUp.isAnimating = true;
      
    }
    
    else if(playerDown == true){
          
    XwingAnimationDown.display(x, y);
       XwingAnimationDown.isAnimating = true;
    }
    
    
    

    //square(x, y, d);
  }

  /*
This function takes updates the position the ball according to its speed.
   */
  void moveUp() {
    if (p1Up == true) {
      y = y - playerSpeed;
      //    println("moveUP");
    }
    //  update player 1 hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;
  }

  void moveDown() {
    if (p1Down == true) {
      y = y + playerSpeed;
      //    println("moveDOWN");
    }
    //  update player 1 hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;
  }

  void move() {
    if (playerUp == true) {
      y = y - playerSpeed;
    }
    if (playerDown == true) {
      y = y + playerSpeed;
    }
    if (p1Left == true) {
      x = x - playerSpeed;
    }
    if (p1Right == true) {
      x = x + playerSpeed;
    }
    //  update player 1 hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;
  }

  /*
This function checks if the ball is touching an edge. If it is, the speed flips
   */
  void wallDetect() {
    // wall detection for the bottom wall
    if (y + d/2 < height) {
      y = y + playerSpeed;
    }
    // wall detection for left wall
    if (y - d/2 > 0) {
      y = y - playerSpeed;
    }
  }


  void collision(EnemyBullet aEnemyBullet) {

    if (top < aEnemyBullet.bottom) {
      if (bottom > aEnemyBullet.top) {
        if (left < aEnemyBullet.right) {
          if (right > aEnemyBullet.left) {

            aEnemyBullet.shouldRemove = true;

            beenHit = true;
            healthNumber -= 1;
           // println("been hit");
          }
        }
      }
    }
  }
}
