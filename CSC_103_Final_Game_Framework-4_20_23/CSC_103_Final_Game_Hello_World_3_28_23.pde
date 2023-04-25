// Gabriel Whitlock
// CSC 103 Final Game Hello World.
// 3-28-23
// My computer wont run the sound library that's why I am using the minim library

import ddf.minim.*;
import processing.video.*;

Minim minim;
AudioPlayer song;
AudioPlayer backgroundSong;
AudioPlayer backgroundSongLoFi;
AudioPlayer backgroundSongEpic;
AudioPlayer backgroundSongArcade;
AudioPlayer darthVaderLoseSong;

// Global vars:

Button[] buttons;
static Level level;
static Level[] levels;
static int levelNumber = 0;
static int state = 0;
static boolean[] keys = new boolean[7];


// Timer Vars:
int startTime; // represents the time we start the stopwatch.
int currentTime; // represents the time we pressed the lap button.

int enemiesKilled;
boolean fireMissile;
boolean once = false;

Movie mov;
Movie deathStar;

// Animation vars:

Animation XwingAnimation;
PImage[] XwingImages = new PImage[2]; // 4 is the number of slots "pictures" in the animation

Animation tieFighterAnimation;
PImage[] tieFightImages = new PImage[2];

Animation playButtonAnimation;
PImage[] playButtonImages = new PImage[2];

Animation XwingAnimationUp;
PImage[] XwingUpImages = new PImage[4];

Animation XwingAnimationDown;
PImage[] XwingDownImages = new PImage[4];

Animation XwingAnimationShoot;
PImage[] XwingShootImages = new PImage[4];

PImage darthVader;
PImage enemyShoot;
// aspect ratio:
float imageScale = 1.5;
float imageScale2 = 1.25;


PImage startScreen;
PImage loseScreen;
PImage winScreen;
PImage controlScreen;
PImage levelScreen;

// level vars:
//int state;

boolean isPressed;
PImage bg;
float bgX = 0;
float speed = 1.5;



// Button Vars:
Button playButton;
Button settingsButton;
Button backButton;
Button nextButton;

// player 1 move booleans
boolean playerUp;
boolean playerDown;
boolean playerShoot;
boolean playerLeft;

boolean LoFiIsPlaying ;
boolean arcadeIsPlaying;
boolean epicIsPlaying ;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);

  LoFiIsPlaying = false;
  arcadeIsPlaying = false;
  epicIsPlaying = false;
  createLevels();
  createButtons();


  playerUp = false;
  playerDown = false;
  playerShoot = false;
  playerLeft = false;

  darthVader = loadImage("darthVaderShip0.png");
  darthVader.resize(int(darthVader.width*imageScale),
    int(darthVader.height*imageScale));

  enemyShoot = loadImage("tieShoot0.png");
  enemyShoot.resize(int(enemyShoot.width*imageScale2),
    int(enemyShoot.height*imageScale2));

  startScreen = loadImage("startScreen1.png");
  startScreen.resize(width, height);

  loseScreen = loadImage("darthVaderLoseScreen.png");
  loseScreen.resize(width, height);

  winScreen = loadImage("winScreen.png");
  winScreen.resize(width, height);

  controlScreen = loadImage("controlScreen.png");
  controlScreen.resize(width, height);

  levelScreen = loadImage("levelScreen.png");
  levelScreen.resize(width, height);

  startTime = millis();
  enemiesKilled = 0;
  minim = new Minim(this);
  song = minim.loadFile("XwingShoot.mp3");
  backgroundSong = minim.loadFile("backgroundTrench.mp3");
  backgroundSongEpic = minim.loadFile("backgroundSongEpic.mp3");
  backgroundSongArcade = minim.loadFile("backgroundSongArcade.mp3");
  backgroundSongLoFi = minim.loadFile("backgroundSongLoFi.mp3");
  darthVaderLoseSong = minim.loadFile("DarthVadeLoseSong.mp3");

  // animation setup:
  for (int index = 0; index < 2; index++) {
    XwingImages[index] = loadImage("XwingShiftRight"+index+".png");
  }
  // animation setup:
  for (int index = 0; index < 4; index++) {
    XwingUpImages[index] = loadImage("XwingShiftRight"+index+".png");
  }
  // animation setup:
  for (int index = 0; index < 4; index++) {
    XwingDownImages[index] = loadImage("XwingShiftLeft"+index+".png");
  }
  // animation setup:
  for (int index = 0; index < 4; index++) {
    XwingShootImages[index] = loadImage("XwingShoot"+index+".png");
  }

  // animation setup:
  for (int index = 0; index < 2; index++) {
    tieFightImages[index] = loadImage("tieFighter"+index+".png");
  }
  // animation setup:
  for (int index = 0; index < 2; index++) {
    playButtonImages[index] = loadImage("playButton"+index+".png");
  }

  // creates the animation object
  tieFighterAnimation = new Animation(tieFightImages, 0.1, 2);

  // creates the animation object
  XwingAnimation = new Animation(XwingImages, 0.2, 2);

  XwingAnimationUp = new Animation(XwingUpImages, 0.5, 2);

  XwingAnimationDown = new Animation(XwingDownImages, 0.5, 2);

  XwingAnimationShoot = new Animation(XwingShootImages, 0.05, 0.65);

  // creates the animation object
  playButtonAnimation = new Animation(playButtonImages, 0.025, 5);
  // background stuff:

  bg = loadImage("background6.png");

  mov = new Movie(this, "X-Wing Targeting Computer Death Star Trench Run.mp4");

  deathStar = new Movie(this, "deathStarDestroy.mp4");
}




void draw() {


  //////////////// Finite State Machine //////////////////////


  switch(state) {
  case 0:

    menu();


    break;
  case 1:
    background(42);
    // music selection stuff:
    if (backgroundSongLoFi.isPlaying() == true) {
      if (backgroundSongLoFi.isPlaying() == false ) {
        backgroundSongLoFi.play(); // if the music is not playing then play.
        backgroundSongLoFi.rewind();
      }
    } else if (backgroundSongArcade.isPlaying() == true) {
      if (backgroundSongArcade.isPlaying() == false ) {
        backgroundSongArcade.play(); // if the music is not playing then play.
        backgroundSongArcade.rewind();
      }
    } else if (backgroundSongEpic.isPlaying() == true) {
      if (backgroundSongEpic.isPlaying() == false ) {
        backgroundSongEpic.play(); // if the music is not playing then play.
        backgroundSongEpic.rewind();
      }
    } else if (backgroundSongLoFi.isPlaying() == false && backgroundSongEpic.isPlaying() == false && backgroundSongArcade.isPlaying() == false) {
      if (backgroundSong.isPlaying() == false ) {
        backgroundSong.play(); // if the music is not playing then play.
        backgroundSong.rewind();
      }
    }
    // actual level play
    level = levels[levelNumber];
    levels[levelNumber].play();

    break;
  case 2:
    controlScreen();

    break;
  case 3:

    chooseLevel();
    break;
  case 4:

    winScreen();
    break;
  case 5:

    loseScreen();
    break;


  case 6:
    backgroundSong.pause();
    backgroundSongLoFi.pause();
    backgroundSongEpic.pause();
    dropZone();
    break;
  case 7:

    cutScene2();
    break;
  }

  // debounces the button presses.
  debounce();
}


void keyPressed() {
  if (key == 'w') {

    playerUp = true;
    //XwingAnimationUp.isAnimating = true;
  }
  if (key == 's') {

    playerDown = true;
    //XwingAnimationDown.isAnimating = true;
  }

  if (key == ' ' && once == true) {
    //XwingAnimationShoot.isAnimating = true;
    playerShoot = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    playerUp = false;
  }
  if (key == 's') {
    playerDown = false;
  }
  if (key == ' ') {
    playerShoot = false;
    once = true;
  }
}



void mousePressed() {

  if (mouseButton==LEFT)
    //isPressed = true;
    keys[4] = true;
}

void debounce() {
  //Will disable the keys, after you press it will automaticly disable making you press only one time.
  if (keys[4])
    keys[4] = false;
}
