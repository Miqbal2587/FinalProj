class Ball{

  //THINGS TO FIX:
  //1 - ADJUST POWER OF SWING BASED ON DISTANCE FROM WHERE MOUSE IS CLICKED
  //2 - MAKE A VELOCITY TOLERANCE RANGE WHEN BALL ENTERS HOLE (IF TOO FAST, BALL WILL GO OVER);
  //Level determination
  int level=1;
  //ball dimensions and stats 
  float xcor, ycor, radius;
  float xVelocity = 0.0, yVelocity = 0.0;
  float topSpeed = 0.5; //to be used later when stroking
 
  //goal dimensions -> this will be put in another class later
  float goalX, goalY, goalWidth;
  
  //misc, to be implemented later
  int strokes = 0;
  // float friction (to be implemented later)
  // float defaultSpeed (to be adjusted later, refers to ballSpeed in mousePressed() )
  // float velocityTolerance (for the hole class)
  //constructor
  Ball(float r, float x, float y){
    radius = r;
    xcor = x;
    ycor = y; } 
    
   //default values - reset when ball reaches hole
   public void setup(){
    strokes = 0;
    
    xcor = 150.0;
    ycor = 150.0;
    xVelocity = 0.0;
    yVelocity = 0.0; 
    radius = 30.0;
    
    //sample hole -> we'll make a seperate hole class later
    goalX = width - 100.0;
    goalY = height - 100.0; 
    goalWidth = 50.0; }
    
   public void moveBall(){
    float xpos =xcor + (xVelocity);
    float ypos =ycor + (yVelocity);
    xcor += xVelocity;
    ycor += yVelocity; 
    
    xVelocity *= 0.97; //placeholder value for friction... higher value means less friction
    yVelocity *= 0.97; 
    
    //tolerance value for ball in hole
    //Added Power to determine if ball is going to fast
    if ( dist(xcor, ycor, goalX, goalY) < (radius +goalWidth) * 0.5 && (xVelocity<5 && yVelocity<5)){
      setup(); //for testing purposes only
      level+=1;
    }
    if (xpos > width - radius || xpos<radius){
          xVelocity = xVelocity * -.95;
        }
    if (ypos>height-radius || ypos<radius){
          yVelocity= yVelocity * -.95;
        }
  }
  
  public void drawBall(){
     fill(255);
     noStroke();
     ellipse(xcor, ycor, radius, radius);
   }
    
  public void draw(){
     background(50,205,50);
     moveBall();
     
     fill (120, 120, 120); //this is the hole
     ellipse(goalX, goalY, goalWidth, goalWidth); //sample hole
     
     drawBall();
     
     text("Strokes: " + strokes, 25, 25); //display stroke count
     text("Level: " + level, 25, 50); //display stroke count
  }
      
  public void mousePressed(float power){
        
      if (mousePressed == true){
        float currentSpeed = dist(0.0, 0.0, xVelocity, yVelocity);
        if (currentSpeed > topSpeed){
          return; }
          
        strokes += 1;  //update stroke count
      
        float angleToMouse = atan2(pmouseY - ycor, pmouseX - xcor);
        float ballSpeed = power; 
        xVelocity = cos(angleToMouse) * ballSpeed;
        yVelocity = sin(angleToMouse) * ballSpeed;
        
        
  }
  }
  //To be used in Obstacle and Course class
  public int getLevel(){
    return level;
  }
  public float getGoalX(){
   return goalX;
  }
  public float getGoalY(){
    return goalY;
  }
  public void setGoalY(float y){
    goalY=y;
  }
  public void setGoalX(float x){
    goalX=x;
  }
  /** to be implemented later
  public int getFriction(){
      return friction;  }
      
   public void setFriction(int x){
       friction = x; } */ 

}
