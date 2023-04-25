class Bullet {


  //vars
  int x;
  int y;
  int d;
  color bc;

  int speed;

  boolean shouldRemove;

  // hitbox vars
  float top;
  float bottom;
  float left;
  float right;

  int enemiesEliminated;


  // constructor

  Bullet(int startingX, int startingY) {

    x = startingX;
    y = startingY;

    d = 10;
    speed = 15;

    shouldRemove = false;

    // initialize hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;

    enemiesEliminated = 0;
  }


  void render() {
    XwingAnimationShoot.isAnimating = true;
    XwingAnimationShoot.display(x,y);
    //circle(x, y, d);
  }

  void move() {
    x += speed;
    // updates hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;
  }

  void checkRemove() {

    if (x > width) {
      shouldRemove = true;
    }
  }

  void collision(Enemy aEnemy) {
    // if the bullet hits the enemy flag the enemy to be removed
    if (top < aEnemy.bottom) {
      if (bottom > aEnemy.top) {
        if (left < aEnemy.right) {
          if (right > aEnemy.left) {
            //println("enemy eliminated");
            aEnemy.shouldRemove = true;
            shouldRemove = true;
            enemiesEliminated++;
            // println(enemiesEliminated);
          }
        }
      }
    }
  }
  void collision2(Boss aBoss) {
    // if the bullet hits the enemy flag the enemy to be removed
    if (top < aBoss.bottom) {
      if (bottom > aBoss.top) {
        if (left < aBoss.right) {
          if (right > aBoss.left) {
            // println("enemy eliminated");
            // aBoss.shouldRemove = true;
            shouldRemove = true;
            aBoss.healthNumber-=10;
            aBoss.beenHit = true;
            // enemiesEliminated++;
            //  println( aBoss.healthNumber);
          }
        }
      }
    }
  }
}
