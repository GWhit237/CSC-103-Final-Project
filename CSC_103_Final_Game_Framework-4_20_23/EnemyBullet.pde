class EnemyBullet {


  //vars
  float x;
  float y;
  int d;
  color bc;

  int speed;

  boolean shouldRemove;

  // hitbox vars
  float top;
  float bottom;
  float left;
  float right;


  int startTime; // represents the time we start the stopwatch.
  int currentTime; // represents the time we pressed the lap button.



  // constructor

  EnemyBullet(float startingX, float startingY, int size) {

    x = startingX;
    y = startingY;

    d = size;
    speed = 12;

    shouldRemove = false;

    // initialize hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;



    startTime = millis();
    currentTime = 0;
  }


  void render() {
image(enemyShoot, x, y);
   // circle(x, y, d);
  }

  void move() {
    x -= speed;

    // updates hitbox vars:
    top = y - d/2;
    bottom = y + d/2;
    left = x - d/2;
    right = x + d/2;
  }

  void checkRemove() {

    if (x < 0) {
      shouldRemove = true;
    }

  }

  
 
}
