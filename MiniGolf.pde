Ball test = new Ball(10, 10, 10, 0, 0);

public void setup(){
  
   size(900,700);
   background(50,205,50);
   stroke(255);  }
   
public void draw(){
  test.display(); }
  
void mousePressed(){
  test.struck(); }