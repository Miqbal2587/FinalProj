Ball test = new Ball(50, 150, 150);

public void setup(){
  
   size(900,700);
   background(50,205,50);
   noStroke();  
   test.setup(); }
   
public void draw(){
  test.mousePressed();
  test.draw(); }
  

  