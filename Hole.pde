class Ball{
  int friction;
  float radius, xcor, ycor;
  int xVelocity, yVelocity;
  
  Ball(float r, float x, float y, int vx, int vy){
    radius = r;
    xcor = x;
    ycor = y;
    xVelocity = vx;
    yVelocity = vy; }
   public int getFriction(){
      return friction; 
   }
   public int setFriction(int x){
       friction =x;
   }
   public void struck(){
     int x = MouseX;
     int y = MouseY;
     int speed = sqrt((pow(xcor+x), 2) + (pow(ycor,+y), 2));
     xVelocity += 1;
     yVelocity += 1; }
     
   public void mousePressed(){
     struck(); }
    
   public void display(){
     stroke(0);
     fill(255);
     ellipse(xcor + xVelocity, ycor + yVelocity, radius, radius); }
}
