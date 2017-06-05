class Hole{
  float radius, xcor, ycor;
  int maxtolerance;
  Hole(){
     radius=20;
     xcor=0;
     ycor=0;
     maxtolerance = 5;
  }
  display(){
     fill(255);
     ellipse(xcor, ycor, radius, radius); 
  }
}
