  
import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 10;
float[] spectrum = new float[bands];

void setup() {
  size(512, 360);
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
}      

void draw() { 
  background(255);
  fft.analyze(spectrum);

  fill(33,231,65,342);
  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //line( i, height, i, height - spectrum[i]*height*5 );
  ellipse(width/bands*i, height/2, width / bands, spectrum[i] * height * 100);
  //println(spectrum[i]);
  } 
  
}