class Particle {
  PVector location;
  PVector velocity; //direction of how an objects changes from one spot to the next
  PVector gravity;
  int hue;
  float saturation;
  float brightness;
  
  //long to create millis (start timer)
  //boolean to set to true that will allow the balls to escape each other
  
  Particle (PVector l, int h, float b) { //happening every frame - update...
    location = l.get();
    velocity = new PVector(random(-10,10), random(-2,0));
    gravity = new PVector(0, .85);
    //adding colors 
    hue = h;
    saturation = 255;
    brightness = b;
   
  }
  
void run() {
    update();
    display();
  }
  
void update() {
    velocity.add(gravity);
    location.add(velocity);
  }
  
 void bounce() {
   if (location.x > width - 16) {
      velocity.x = velocity.x * -.9; //simulates bounce energy loss
      location.x = width-16;
        
    }
    else if (location.x < 16) {
      velocity.x = velocity.x * -1;
      location.x = 16;
    }
  
    if (location.y > height - 16){
      velocity.y = velocity.y * -1;
      velocity.x = velocity.x * .99; //this simulates ground friction
      location.y = height;
       
    }
    else if (location.y < 16) {
      velocity.y = velocity.y * -1;
      location.y = 16;
    }
 }
 
 void collision (ArrayList list){
   for(int i = list.size()-1; i >= 0; i--) {
      Particle w = (Particle)list.get(i);
   if(location.dist(w.location) < 20 && location.dist(w.location) > 0) {
     velocity.x = velocity.x * -1; 
     velocity.y = velocity.y * -1; 
     
     w.velocity.x = w.velocity.x * -1;
     w.velocity.y = w.velocity.y * -1;
   }
   }
 }
   
 
 void gravOn (ArrayList list){
   for (int i = list.size()-1; i >= 0; i--) {
    Particle w = (Particle)list.get(i);
     if(keyPressed == true){
        gravity.x = gravity.x * .4; 
        gravity.y = gravity.y * .4;  
        w.gravity.x = w.gravity.x * .4;
        w.gravity.y = w.gravity.y * .4;
   }  
  }
 }
     
void display() {
  stroke(0);
  strokeWeight(1);
  fill(hue, saturation, brightness); //color that will be generated from cam
  ellipse(location.x, location.y, 40, 40);
}
}
  


