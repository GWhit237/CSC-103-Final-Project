class HealthBar {

  // vars:

  int x;
  int y;
  float w;
  int h;

  color c;

  boolean shouldRemoveBoss;


  // constructor

  HealthBar(int startingX, int startingY, int startingHealth) {

    x = startingX;
    y = startingY;
    w = startingHealth;
    h = 20;

    c = color(0, 255, 0);

    shouldRemoveBoss = false;
  }



  void runB(Boss aBoss) {
    if (aBoss.isDead == false) {
      fill(c);
      rect(x, y, w, h);

      float value = map(aBoss.healthNumber, 0, aBoss.bossHealth, 0, 100);
      if (aBoss.beenHit == true) {
        w = int(value);
       
       
        aBoss.beenHit = !aBoss.beenHit;
      }
      // fill(c);
      //rect(x, y, w, h);
      if (w <= 0) {
        w = 0;
      }
      if (w == 50) {
        c = color(#FAE605);
      }
      if (w == 25) {
        c = color(#F21D24);
      }
    }
  }

  void render() {
    fill(c);
    rect(x, y, w, h);
  }


  void playerHealth(Player aPlayer) {
    if (aPlayer.isDead == false) {
      fill(c);
      rect(x, y, w, h);
      if (aPlayer.beenHit == true && aPlayer.isDead == false && w > 0) {
        w = w - 1;
        aPlayer.beenHit = !aPlayer.beenHit;
      }
      // println(w);
      if (w <= 0) {
        w = 0;
      }
      if (w == 50) {
        c = color(#FAE605);
      }
      if (w == 25) {
        c = color(#F21D24);
      }
    } else {
      state = 5;
    }
  }
}
