class Button {

  // Button Vars:
  float posX;
  float posY;
  //float Width = 0;
  //float Height = 0;
  color colorA;

  boolean Pressed = false;
  boolean Clicked = false;
  boolean isInBetween;

  PImage buttonImg;
  PImage buttonPressedImg;
  int wScale;
  int hScale;
  String text;


  Button(float x, float y, float  w, float h, String t) {

    posX = x ;
    posY = y;
    //Width = w;
    //Height = h;
    colorA = color(255);
    wScale = round(w);
    hScale = round(h);
    text = t;

    buttonImg = loadImage("Button.png");
    buttonImg.resize(wScale, hScale);
    buttonPressedImg = loadImage("ButtonPressed.png");
    buttonPressedImg.resize(wScale, hScale);
  }


  void update() {
    if (mouseX >= posX-(wScale/2) && mouseX <= posX+(wScale/2) && mouseY >= posY-(hScale/2) && mouseY <= posY+(hScale/2))
      isInBetween = true;
    else
      isInBetween = false;



    if (isInBetween) {
      image(buttonPressedImg, posX, posY);
      fill(255);
      textSize(resizeX(50));
      textAlign(CENTER, CENTER);
      text(text, posX, posY);
    } else {
      image(buttonImg, posX, posY);
      fill(0);
      textSize(resizeX(50));
      textAlign(CENTER, CENTER);
      text(text, posX, posY);
    }
  }


  boolean isClicked() {// checks if button was clicked
    if (isInBetween && keys[4])
      return true;
      
    
    return false;
  }







  //_________________________________________________ get functions

  //  boolean getIsPressed() {
  //    if (mouseInside && keys[4])
  //      return true;

  //    return false;
  //  }
  //float x;
  //float y;

  //float w;


  //boolean isPressed;


  //Button(float startingX, float startingY, float startingWidth){

  //  x = startingX;
  //  y = startingY;
  //  w = startingWidth;



  //  isPressed = false;

  //}

  boolean isBetween(float a, float b, float c) {
    if ( a > b && c > a) {
      // println("true");
      return true;
    } else {
      return false;
    }
  }

  boolean isInButton(float aX, float aY, float aW) {
    if ( isBetween(mouseX, aX - (aW/2), aX + (aW/2)) == true && isBetween(mouseY, aY - (aW/2), aY + (aW/2)) == true) {
      return true;
    } else {
      return false;
    }
  }
}
