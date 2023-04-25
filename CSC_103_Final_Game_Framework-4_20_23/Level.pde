class Level {
  // constructs levels in the game:
  // vars:
  ArrayList<Enemy> enemies;
  ArrayList<Bullet> bullets;
  Player player1;
  Boss boss1;
  HealthBar playerH1;
  HealthBar bossH1;
  int eSpawnRate;
  int eFireRate;
  int eSpeed;
  float bossSpeed;
  int bHealth;
  int bFireRate;
  int bSpawn;


  Level(int startingSpawnRate, int startingFireRate, int enemySpeed, float bossStartingSpeed,
    int bossStartingHealth, int bossFireRate, int bossSpawn, int playerHealth) {

    eSpawnRate = startingSpawnRate;
    eFireRate = startingFireRate;
    eSpeed = enemySpeed;
    bossSpeed = bossStartingSpeed;
    bHealth = bossStartingHealth;
    bFireRate = bossFireRate;
    bSpawn = bossSpawn;
    boss1 = new Boss(width, height/2, bossStartingHealth, bossStartingSpeed);
    enemies = new ArrayList<Enemy>();
    bullets = new ArrayList<Bullet>();
    playerH1 = new HealthBar(width/5, height-50, playerHealth);
    bossH1 = new HealthBar(4*width/5, height-50, bossStartingHealth);
    player1 = new Player(50, height/2, XwingAnimation, playerHealth);
  }




  void play() {
    // draw the background image
    image(bg, bgX, 0);
    image(bg, bgX - bg.width, 0);

    // update the background position
    bgX -= speed;
    if (bgX < -bg.width/100) {
      bgX += bg.width;
    }


    currentTime = millis();

    if (currentTime - startTime >= eSpawnRate) {
      // println( "the timer is triggered!");
      
      enemies.add(new Enemy(width, random(20, height - 20), eFireRate, eSpeed)); // 350
      startTime = millis();
    }
   
    boss1.interval = bFireRate; // changes the rate of boss fire

    playerH1.playerHealth(player1);


    player1.render();
    
    player1.wallDetect();
    player1.move();
    if (playerShoot == true) {
      playerShoot = false;
      once = false;
      bullets.add(new Bullet(player1.x, player1.y));
      song.play();
      song.rewind();
    }
    // checks to see if enemy bullete has hit player
    for (Enemy aEnemy : enemies) {
      for (EnemyBullet aEnBullet : aEnemy.enemyBullets) {
        player1.collision(aEnBullet);
      }
    }
    // checks to see if boss bullet has hi player
    for (EnemyBullet aEnBullet : boss1.enemyBullets) {
      player1.collision(aEnBullet);
    }

    // for loop that goes through all bullets
    for (Bullet aBullet : bullets) {

      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();
      aBullet.collision2(boss1); // checks to see if player bullets have hit boss

      for (Enemy aEnemy : enemies) {
        aBullet.collision(aEnemy); // checks to see if player bullets have hit an enemy

        if ( aBullet.enemiesEliminated == 1) {
          enemiesKilled++; // ticks up everytime an enemy is hit by the player. This will be used to spawn boss and for score.
        }
      }
    }
    //  println(enemies.size());

    // for loop that removes unwanted bullets

    for ( int i = bullets.size()-1; i >= 0; i--) {
      Bullet aBullet = bullets.get(i);

      if (aBullet.shouldRemove == true) {
        bullets.remove(aBullet);
      }
    }

    // for loop that removes killed enemies
    for ( int i = enemies.size()-1; i >= 0; i--) {
      Enemy aEnemy = enemies.get(i);

      if (aEnemy.shouldRemove == true) {
        enemies.remove(aEnemy);
      }
    }

    for (Enemy aEnemy : enemies) {
      aEnemy.render();
      aEnemy.move();
      aEnemy.wallDetect();
      aEnemy.renderBullet();
      aEnemy.shootBullet();
      aEnemy.removeBullets();
      // println("enemy spawn");
    }

    if (enemiesKilled > bSpawn) {
      boss1.run();
      bossH1.runB(boss1);
    }
    if (boss1.healthNumber < 0) {
      boss1.isDead = true;
      state = 6;
      backgroundSong.pause();
      backgroundSongLoFi.pause();
      backgroundSongEpic.pause();
      backgroundSongArcade.pause();
    }
    if (player1.healthNumber < 0) {
      player1.isDead = true;
      state = 5;
      println("player dead");
      backgroundSong.pause();
      backgroundSongLoFi.pause();
      backgroundSongEpic.pause();
      backgroundSongArcade.pause();
    }

    playerScore();
  }


  void playerScore() {
    fill(255);
    textSize(40);
    text(enemiesKilled, width/2, height-45);
  }
}
