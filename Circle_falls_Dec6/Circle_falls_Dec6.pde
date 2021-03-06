 //http://www.catehuston.com/blog/2013/08/26/extracting-the-dominant-color-from-an-image-in-processing/
ArrayList<Particle> walker; //declare the variable and what's going in the arraylist


import processing.video.*;
//import processing.core.PApplet;
//import processing.core.PImage;

Capture cam;
PImage frame;
PImage bkgd;
PFont myFont;
int ctrRow = 0;
int ctrCol = 1;
int rectsize = 20;
int delay = 100; //milliseconds. The waiting time before thenew hue is captured
int time;
boolean newrect = true;
// parameters for color capture
float prevhue = 1;
float hueThreshold = 30;
static final int hueRange = 360; 
float saturation;
float brightness;
int i = 0;
int hue;


IntList capturedHues;
IntList capturedTimes;


int hourEqSecs = 10; //  means that after every 3600 seconds the boxes will be populatedin the next segment
int numHours = 12; // The number of segments to have on the display screen
int shift=0;
boolean nextHr;

void setup() {
  size(1050,650);
  bkgd = loadImage("bkgd.jpg");
  walker = new ArrayList <Particle>();
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();    
  time = millis(); 
  colorMode(HSB, (hueRange - 1));
  //frame = loadImage("pic2.jpg");
  noStroke();
  capturedHues = new IntList();
  capturedTimes = new IntList();
  myFont = createFont("Arial",32);
  textFont(myFont,15);  
}

void draw() {
  background(255);
  image(bkgd,0,0);
  fill(0,0,0);
  if (cam.available() == true) {
    cam.read();
  }
  //image(cam, 0, 0, width/4, height/4);
  frame = cam;
  stroke(255);
  noFill();
  //rect(width/12, height/12, width/12, height/12);
  //stroke(0);
  //frame = get(width/12, height/12, width/12, height/12);
  hue = extractColorFromImage();
  if( abs(prevhue-hue) > hueThreshold & (millis()-time) >delay) {
    walker.add(new Particle(new PVector (width/2,140), hue, brightness));
  if(millis()/(hourEqSecs*1000)*(width/numHours) != shift) {
    shift = millis()/(hourEqSecs*1000)*(width/numHours);
    }
    prevhue = hue; 
    time = millis();
 }

   for(int i = walker.size()-1; i >= 0; i--) {
    Particle w = walker.get(i);
    w.run();
    w.bounce(); 
    w.collision(walker); 
    w.gravOn(walker);
  } 
}

int extractColorFromImage() {
    frame.loadPixels();
    int numberOfPixels = frame.pixels.length;
    int[] huesArray = new int[hueRange];
    float[] saturations = new float[hueRange];
    float[] brightnesses = new float[hueRange];

    for (int i = 0; i < numberOfPixels; i++) {
      int pixel = frame.pixels[i];
      int hueVal = Math.round(hue(pixel));
      float saturation = saturation(pixel);
      float brightness = brightness(pixel);
      huesArray[hueVal]++;
      saturations[hueVal] += saturation;
      brightnesses[hueVal] += brightness;
    }
    // Find the most common hue.
    int hueCount = huesArray[1];
    int hue = 0;
    for (int i = 2; i < huesArray.length; i++) {
       if (huesArray[i] > hueCount) {
        hueCount = huesArray[i];
        hue = i;
      }
    }
    println("The max hue is: ",hue, " with hueCount ", hueCount);

    this.hue = hue;

    brightness = brightnesses[hue] / hueCount;

    return hue;

  }


