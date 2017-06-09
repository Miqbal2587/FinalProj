class Ball{

  //THINGS TO FIX:
  //1 - KEEP TESTING VELOCITY TOLERANCE RANGE WHEN BALL ENTERS HOLE (IF TOO FAST, BALL WILL GO OVER);
  //2 - FINE TUNE THE BALL'S INTERACTION WITH OBSTACLE
  //3 - EXPORT HOLE AND OBSTACLE CLASSES INTO SEPARATE CLASSES ***
  //4 - START WORKING ON TERRAIN DEVELOPMENT
  
  
  //Level determination
  int level=1;
  //ball dimensions and stats 
  float xcor, ycor, radius;
  float xVelocity = 0.0, yVelocity = 0.0;
 
  //goal dimensions -> this will be put in another class later
  float goalX, goalY, goalWidth;
  
  float topSpeed = 0.5; //for strokes
  
  //display variables
  int distance, speed;
  
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
    goalX = width/2;
    goalY = height/2; 
    goalWidth = 50.0;
    setupWall();
    drawWall(); }
    
   public void displayDist(){
     distance =  int(dist(xcor, ycor, goalX, goalY)); }
     
   public void displaySpeed(){
      speed = int(sqrt( pow(xVelocity, 2) + pow(yVelocity, 2))); //true velocity formula
   }
   
   //semi random values - use general ranges
   public boolean isSpeedValid(){
    if (distance <= 200 && speed >= 30){
        return false; }
    return true;
       
     
   }
   
   
   public void moveBall(){
    float xpos =xcor + (xVelocity);
    float ypos =ycor + (yVelocity);
    xcor += xVelocity;
    ycor += yVelocity; 
    
    xVelocity *= 0.97; //placeholder value for friction... higher value means less friction
    yVelocity *= 0.97; 
    
    //tolerance value for ball in hole
    //Added Power to determine if ball is going to fast
    if ( dist(xcor, ycor, goalX, goalY) < (radius +goalWidth) * 0.5 && isSpeedValid()){
      setup(); //for testing purposes only
      level+=1;
    }
    if (xpos > width - radius || xpos<radius){
          xVelocity = xVelocity * -.95;
        }
    if (ypos>height-radius || ypos<radius){
          yVelocity= yVelocity * -.95;
        }
        
    //work on bouncing off wall/obstacle
    if ((xpos < obsX + obsWid && xpos > obsX) && (ypos < obsY + obsHeight && ypos > obsY)){
      xVelocity *= -.95; 
      yVelocity *= -.95; }           
    
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
     
     drawWall();
     drawBall();
     
     text("Strokes: " + strokes, 25, 25); //display stroke count
     text("Level: " + level, 25, 50); //display stroke count
     text("Distance to Goal: " + distance, 25, 75); //for testing purposes
     text("Ball Speedometer: " + speed, 25, 100); //for testing purposes
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
       
   //instance variables for osbtacle
  int obstacleType = 0; //default 0 is brick wall
  int obsX, obsY, obsHeight, obsWid;
 
  //default values
  public void setupWall(){
   obsX = 375;
   obsY = 300;
   obsHeight = 50;
   obsWid = 65;
  }
  
  public void drawWall(){
    fill(220,20,60); //crimson
    noStroke();
    rect(obsX,obsY,obsHeight,obsWid);
  }    
  
  //terrain types
  int terrainType; //1 - elevation(dark green), 2 - depression(light green), 3 - sand, 4 - water
  int terrainShape; //1 - arc, 2 - ellipse, 3 - quad, 4 - rect, 5 - triangle
  
  
  
  
       
       

}