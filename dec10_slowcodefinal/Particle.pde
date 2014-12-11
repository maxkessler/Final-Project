class Particle {
  PVector location;
  PVector velocity; //direction of how an objects changes from one spot to the next
  PVector gravity;
  int hue;
  float saturation;
  float brightness;
  
  Particle (PVector l,int h, float b) { 
    location = l.get();
    velocity = new PVector(random(-10,10), random(-2,0));
    gravity = new PVector(0, 0.8);
    hue = h;
    saturation = 255;
    brightness = b;
    
  }
  
void run() {
    update();
    display();
  }
  
void update() {
    location.add(velocity);
    velocity.add(gravity);
  }
  
 void bounce() {
   if (location.x > width - 16) {
      velocity.x = velocity.x * -.5; //simulates bounce energy loss
      location.x = width-16;
        
    }
    else if (location.x < 16) {
      velocity.x = velocity.x * -.5;
      location.x = 16;
    }
  
    if (location.y > height - 16){
      velocity.y = velocity.y * -0.8;
      velocity.x = velocity.x * .99; //this simulates ground friction
      location.y = height - 16;
       
    }
    else if (location.y < 16) {
      velocity.y = velocity.y * -0.8;
      location.y = 16;
    }
 }
 
 void collision (ArrayList list){ 
   for(int i = list.size()-1; i >= 0; i--) {
      Particle w = (Particle)list.get(i);
   if(location.dist(w.location) < 15 && location.dist(w.location) > 0) {
     velocity.x = velocity.x * -1; 
     velocity.y = velocity.y * -1; 
     w.velocity.x = w.velocity.x * -1;
     w.velocity.y = w.velocity.y * -1;
   }
 }
 }

   
void display() {
  stroke(0);
  fill(hue, saturation, brightness);
  ellipse(location.x, location.y, 30, 30);
}

}
