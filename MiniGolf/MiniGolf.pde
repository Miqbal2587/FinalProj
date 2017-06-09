import controlP5.*;
ControlP5 MyController;
Ball test = new Ball(50, 150, 150);

float power=25;
public void setup(){
  
   size(900,700);
   background(50,205,50);
   noStroke();
   //Hover over Power and scroll to change the Power
   MyController = new ControlP5(this);
   MyController.addSlider("Power",0,40,power,20,100,10,100);
   test.setup(); }
   
public void draw(){
  power=MyController.getController("Power").getValue();
  test.displayDist();
  test.displaySpeed();
  test.mousePressed(power);
  test.draw(); 
}