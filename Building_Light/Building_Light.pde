import processing.sound.*;
Amplitude amp;
AudioIn in;
   
int numRow = 30;
int numCol = 30;
Window[][] windows = new Window[numRow][numCol];
float windowX, windowY; 
//int marginX = 10;
//int marginY = 8;
float marginX = 5;
float marginY = 2;
float windowWidth = 40;
float windowHeight = 30;
String[] options = {"redoff", "greenoff", "blueoff",};
int optionNum = 0;
float rotation;
float _o;
  

void setup() {
  size(800, 800);
  frameRate(30);
  noStroke();
  //int marginLeft = (800 - (numRow * marginX) - (numRow * windowWidth)) / 2;
  float marginLeft = 0;
  float marginTop = 0;
  //int marginTop = (800 - (numCol * marginY) - (numCol * windowHeight)) / 2;
  for (int i = 0; i < numRow; i++){
    for (int j = 0; j < numCol; j++){
      //windowX = marginLeft + (marginX + windowWidth) * i;
      //windowY = marginTop + (marginY + windowHeight) * j;
      windowX =(marginX + windowWidth) * i;
      windowY = (marginY + windowHeight) * j;
      windows[i][j] = new Window(windowX, windowY, windowWidth, windowHeight, 255); 
    }
  }
  //sound
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  
  float rotation = radians(0);
}

int n = 0;
void draw() {
  background(51);
  if(n < 100){
    if (randomBool(.93)){
      if (optionNum == 2){
       optionNum = 0;
      }
      optionNum ++;
    }
    
   for (int i = 0; i < numRow; i++){
     for (int j = 0; j < numCol; j++){
       Window window = windows[i][j];
       window.changeLightColor(options[optionNum]);
       window.turnLight(randomBool(.5));
       window.display();
     }
   }
   n++;
  }
  windowHeight = amp.analyze() * 2000;
  rotation = amp.analyze() * 3000;
  println(windowHeight);
  if (amp.analyze() * 50 > 1){
      //gaussian experiment
      float gau = randomGaussian();
      windowWidth = (gau * 60);
      _o = gau;
      
    for (int i = 0; i < numRow; i++){
      for (int j = 0; j < numCol; j++){
        Window window = windows[i][j];
        window.turnLight(randomBool(.2));
        window.changeLightColor(options[optionNum]);
        window.display();
      }
    } 
    if (randomBool(.93)){
      if (optionNum == 2){
         optionNum = 0;
        }
        optionNum ++;
    }
  }
  else{
    windowHeight = amp.analyze() * 2000;
    for (int i = 0; i < numRow; i++){
      for (int j = 0; j < numCol; j++){
        Window window = windows[i][j];
        window.turnLight(randomBool(.99));
        window.display();
      }
    }
  }
  

}

class Window{
  float _x, _y, _w, _h, _rgb;
  int _r, _g, _b;
  Window(float x, float y, float w, float h, int rgb){
    _x = x;
    _y = y;
    _w = w;
    _h = h;
    _rgb = rgb;
  }
  void turnLight(boolean boo){
   if (boo){
     _o = 255;
   }
   else{
     _o = 0;
   }
  }
  void changeLightColor(String option){
    _r = int(random(255));
    _g = int(random(255));
    _b = int(random(255));
    
    if(option == "redoff"){
      _r = 0;
    }
    else if (option == "greenoff"){
      _g = 0;
    }
    else if (option == "blueoff"){
      _b = 0;
    }
  }
  void display(){
    fill(_r,_g,_b, _o);
    rect(_x, _y, windowWidth, windowHeight);
    rotate(rotation);
  }
}

boolean randomBool(float limit){
   return random(1) > limit; 
}