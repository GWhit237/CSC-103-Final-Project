class Boss {

  //vars:

  float x;
  float y;
  int w;
  int h;

  color c;

  float xSpeed;
  float ySpeed;

  int healthNumber;
  int bossHealth;

  boolean beenHit;

  // hitbox vars
  float top;
  float bottom;
  float left;
  float right;

  boolean isDead;

  ArrayList<EnemyBullet> enemyBullets;
  int startTime3; // represents the time we start the stopwatch.
  int currentTime3; // represents the time we pressed the lap button.
  int interval;

  // constructor

  Boss(float startingX, float startingY, int startingHealth, float startingYspeed) {

    x = startingX;
    y = startingY;

    w = 75;
    h = 100;
    c = color(0, 255, 0);

    xSpeed = 2.5;
    ySpeed = startingYspeed;

    beenHit = false;
    healthNumber = startingHealth;
    bossHealth  = startingHealth;

    top = y - h/2;
    bottom = y + h/2;
    left = x - w/2;
    right = x + w/2;

    isDead = false;
    enemyBullets = new ArrayList<EnemyBullet>();
    startTime3 = millis();

    interval = 1000;
  }

  void run() {
    //if (!isDead) {
    if (isDead == false) {

      // fill(c);
      image(darthVader, x, y);
      // rect(x, y, w, h);
      /*
This function takes updates the position the ball according to its speed.
       */

      for (EnemyBullet aenemyBullet : enemyBullets) {

        aenemyBullet.render();
        aenemyBullet.move();
      }

      currentTime3 = millis();

      if (currentTime3 - startTime3 >= interval) {
        enemyBullets.add(new EnemyBullet(x, y, 25));
        //println( "enemy fires");
        startTime3 = millis();
      }

      for ( int i = enemyBullets.size()-1; i >= 0; i--) {
        EnemyBullet aEnemyBullets = enemyBullets.get(i);

        if (aEnemyBullets.shouldRemove == true) {
          enemyBullets.remove(aEnemyBullets);
        }
      }

      if (x > 5*width/6) {
        x = x - xSpeed;
      }
      //  x += xSpeed;
      y += ySpeed;

      top = y - h/2;
      bottom = y + h/2;
      left = x - w/2;
      right = x + w/2;

      /*
This function checks if touching an edge. If it is, the speed flips
       */
      // wall detection for the bottom wall
      if (y+h/2 >= height) {
        ySpeed = -abs(ySpeed);
        // println("at bottom");
      }
      // wall detection for left wall
      if (y-h/2 <= 0) {
        ySpeed = abs(ySpeed);
        //  println(ySpeed);
      }
    }
  }
}
