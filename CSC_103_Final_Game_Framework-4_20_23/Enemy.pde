class Enemy {
  /*
  Class variables
   */
  int x;
  float y;
  int d;
  color fillColor;

  int xSpeed;

  // hitbox vars
  float top;
  float bottom;
  float left;
  float right;

  boolean shouldRemove;



  ArrayList<EnemyBullet> enemyBullets;

  int startTime2; // represents the time we start the stopwatch.
  int currentTime2; // represents the time we pressed the lap button.
  int interval;
  /*
  Constructor
   */

  Enemy(int startingX, float startingY, int anInterval, int startingSpeed) {
    int speedMag = 10;
    interval= anInterval;
    xSpeed = startingSpeed;
    startTime2 = millis();
    enemyBullets = new ArrayList<EnemyBullet>();

    if (xSpeed == 0) {
      xSpeed = speedMag;
    }

    x = startingX;
    y = startingY;
    d = 50;
    fillColor = color(255, 0, 0);

    // initialize hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;

    shouldRemove = false;
  }

  void render() {
    fill(fillColor);
    tieFighterAnimation.isAnimating = true;
    tieFighterAnimation.display(x,int(y));
    //circle(x, y, d);
  }

  /*
This function takes updates the position the ball according to its speed.
   */
  void move() {
    x += -xSpeed;
    // updates hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;
  }


  void renderBullet() {
    // for loop that goes through all bullets
    for (EnemyBullet aenemyBullet : enemyBullets) {

      aenemyBullet.render();
      aenemyBullet.move();
    }
  }

  /*
This function checks if the ball is touching an edge. If it is, the speed flips
   */
  void wallDetect() {
    // wall detection for left wall
    if (x-d/2 <= 0) {
      shouldRemove = true;
    }
  }

  void shootBullet() {
    currentTime2 = millis();

    if (currentTime2 - startTime2 >= interval) {
      enemyBullets.add(new EnemyBullet(x, y, 25));
      //println( "enemy fires");
      startTime2 = millis();
    }
  }

  // for loop that removes killed enemies
  void removeBullets() {
    for ( int i = enemyBullets.size()-1; i >= 0; i--) {
      EnemyBullet aEnemyBullets = enemyBullets.get(i);

      if (aEnemyBullets.shouldRemove == true) {
        enemyBullets.remove(aEnemyBullets);
      }
    }
  }
}
