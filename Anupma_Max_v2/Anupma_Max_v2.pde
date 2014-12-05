ArrayList<Particle> walker; //declare the variable and what's going in the arraylist

Capture cam;
PImage frame;
int ctrRow = 0;
int ctrCol = 1;
int rectsize = 20;
int delay = 500; //milliseconds. The waiting time before thenew hue is captured
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

void setup(){
  size(900,450);
  walker = new ArrayList <Particle>();
}

void draw(){ 
  background (255);
  for(int i = walker.size()-1; i >= 0; i--) {
    Particle w = walker.get(i);
    w.run();
    w.bounce(); 
    w.collision(walker);//chekcing the collection of arraylist
   
}
}

void mousePressed() {
  walker.add(new Particle(new PVector (width/2,40)));
}



