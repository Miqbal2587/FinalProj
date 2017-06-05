class Ball{
 
  float radius, xcor, ycor;
  int xVelocity, yVelocity;
  
  Ball(float r, float x, float y, int vx, int vy){
    radius = r;
    xcor = x;
    ycor = y;
    xVelocity = vx;
    yVelocity = vy; }
    
   public void struck(){
     xVelocity += 1;
     yVelocity += 1; }
     
   public void mousePressed(){
     struck(); }
    
   public void display(){
     stroke(0);
     fill(255);
     ellipse(xcor + xVelocity, ycor + yVelocity, radius, radius); }
  
  
}