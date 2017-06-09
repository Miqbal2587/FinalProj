class Ball{

  //THINGS TO FIX:
  //1 - KEEP TESTING VELOCITY TOLERANCE RANGE WHEN BALL ENTERS HOLE (IF TOO FAST, BALL WILL GO OVER);
  //2 - FINE TUNE THE BALL'S INTERACTION WITH OBSTACLES
  
  // 6/8 UPDATE
  //3 - FIX BALL'S INTERACTION WITH TERRAIN
  //4 - The ball has weird bugs sometimes (doesn't touch terrain but still accelerates/decelerates)
  //5 - Make ball's speed in terms of sqrt(xvelocity^2 + yvelocity^2) instead of separate x and y velocity components
  
  
  //Level determination - to be used later for course generation
  int level=1;
  
  //ball dimensions and stats 
  float xcor, ycor, radius;
  float xVelocity = 0.0, yVelocity = 0.0;
  float topSpeed = 0.5; //for strokes
  
  //goal dimensions
  float goalX, goalY, goalWidth;
 
  //display variables
  int distance, speed;
  int strokes = 0;
  
  
  // float friction (to be implemented later)
  
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
    
    //sample hole
    goalX = width/2;
    goalY = height/2; 
    goalWidth = 50.0;
    
    //sample wall obstacle
    setupWall();
    drawWall();
    
    //sample water terrain
    setupTerrain(3,4,1,4);
    drawTerrain(2,1,4); }
    
   public void displayDist(){
     distance =  int(dist(xcor, ycor, goalX, goalY)); }
     
   public void displaySpeed(){
     //true velocity formula
      speed = int(sqrt( pow(xVelocity, 2) + pow(yVelocity, 2))); }
   
   //semi random values - use general ranges
   //this is velocity tolerance for hole
   public boolean isSpeedValid(){
    if (distance <= 200 && speed >= 30){
        return false; }
    return true; }
   
   //most important function
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
      setup(); //for testing purposes only, we'll progress levels later
      level+=1; }
      
    //bounce off walls  
    if (xpos > width - radius || xpos<radius){
          //placeholder values
          xVelocity = xVelocity * -.95; }
    if (ypos>height-radius || ypos<radius){
          yVelocity= yVelocity * -.95; }
        
    //work on bouncing off wall/obstacle
    if ((xpos < obsX1 + obsWid1 && xpos > obsX1) && (ypos < obsY1 + obsHeight1 && ypos > obsY1)){
      xVelocity *= -.95; 
      yVelocity *= -.95; }    
      
      
    //INTERACTION WITH TERRAIN
    
    //BUG - THIS ONLY WORKS FOR RECTANLES, ADJUST FOR CIRCLES LATER
    //BUG - *** Ball gets affcted even though it's not touching terrain, work on adjusting coordinates later
    if ((xpos < terrainX1 + terrainWid1 && xpos > terrainX1) && 
      (ypos < terrainY1 + terrainHeight1 && ypos > terrainY1)){
        
        //elevation - continually reverses ball's velocity (speeds down, then speeds up other way)
        //this has many bugs, WORK ON COMPLETELY REVERSING BALL'S DIRECTION RATHER THAN DEFLECTING
        if (terrainType1 == 1){
           while (xVelocity > 0.05 && yVelocity > 0.05){
             xVelocity *= 0.05;
             yVelocity *= 0.05; }
            
           if (xVelocity > yVelocity){
             xVelocity = -5;
             yVelocity = 0.01; }
           else{
             yVelocity = -5;
             xVelocity = 0.01;}
             
        }
             
        //depression - adds a boost to ball's speed
        //should work fine, but sometimes ball accelerates even when it's not in the terrain
        if (terrainType1 == 2){
          xVelocity *= 1 + (0.1 * terrainMod1);
          yVelocity *= 1 + (0.1 * terrainMod1);  }
        
        //sand - slows down ball until speed is 0
        //works fine
        if (terrainType1 == 3){
          if (xVelocity > 0){
            xVelocity -= terrainMod1; }
          else{
            xVelocity = 0; }
            
          if (yVelocity > 0){
            yVelocity -= terrainMod1; }
          else{
             yVelocity = 0; }
        }
        
        //water resets the ball's original coordinates
        //works fine
        if (terrainType1 == 4){
          xcor = 150.0;
          ycor = 150.0;
          xVelocity = 0.0;
          yVelocity = 0.0; 
          radius = 30.0; }
       }
       
   }
  
  public void drawBall(){
     fill(255);
     noStroke();
     ellipse(xcor, ycor, radius, radius); }
    
  public void draw(){
     background(50,205,50);
     moveBall();
     
     fill (120, 120, 120); //this is the hole
     ellipse(goalX, goalY, goalWidth, goalWidth); //sample hole
     
     drawWall();
     drawTerrain(2,1,4);
     
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
        yVelocity = sin(angleToMouse) * ballSpeed; }
  }
  
  //To be used in Obstacle and Course ge
 
  /** to be implemented later
  public int getFriction(){
      return friction;  }
      
   public void setFriction(int x){
       friction = x; } */ 
       
   //instance variables for osbtacle
  int obstacleType = 0; //default 0 is brick wall
  int obsX1, obsY1, obsHeight1, obsWid1;
  int obsX2, obsY2, obsHeight2, obsWid2; //for more obstacles to be added
 
  //default values, add parameters later
  public void setupWall(){
   obsX1 = 375;
   obsY1 = 300;
   obsHeight1 = 50;
   obsWid1 = 65; }
  
  public void drawWall(){
    fill(220,20,60); //crimson
    noStroke();
    rect(obsX1,obsY1,obsHeight1,obsWid1); }    
  
  //general values
  //we can fix this later but make friction/slope adjustable as level progresses
  //"mod" variable refers to how it modifies ball's velocity; we'll work on this later after testing some default values
  //type refers to terrain type
  int terrainX1, terrainY1, terrainHeight1, terrainWid1, terrainMod1, terrainType1; //refers to each instance of a terrain, let's set a max amount later
  int terrainX2, terrainY2, terrainHeight2, terrainWid2, terrainMod2, terrainType2;
  int terrainX3, terrainY3, terrainHeight3, terrainWid3, terrainMod3, terrainType3;
  int terrainX4, terrainY4, terrainHeight4, terrainWid4, terrainMod4, terrainType4;
  int terrainX5, terrainY5, terrainHeight5, terrainWid5, terrainMod5, terrainType5;
  
  //for size -> 1 - small, 2 - medium, 3 - large
  //type refers to type of terrain
  //number refers to the instance of the terrain
  //the higher the difficulty, the more it will affect the ball's velocity
  public void setupTerrain(int size, int type, int number, int difficulty){
  
      //default values to be adjusted later
      if (number == 1){
        terrainX1 = 200;
        terrainY1 = 200;
        terrainHeight1 = 35 * size;
        terrainWid1 = 45 * size;
        terrainMod1 = difficulty; //1 - easy, 2 - medium, 3 - hard;
        terrainType1 = type; }
        
      if (number == 2){
        terrainX2 = 200;
        terrainY2 = 200;
        terrainHeight2 = 35 * size;
        terrainWid2 = 45 * size;
        terrainMod2 = difficulty; 
        terrainType2 = type; }
        
  }
        
  //velocity will be affected in the ball's move function
   
  //terrain types 1 - elevation(dark green), 2 - depression(light green), 3 - sand, 4 - water    
  //for shape -> 1 - ellipse, 2 - rect (basic shapes, add more later)   
  public void drawTerrain(int shape, int number, int type){
    
     if (type == 1){
        //dark green
        fill(0,100,0); }
        
      if (type == 2){
        //light green
        fill(144,238,144); }
        
      if (type == 3){
        //golden
        fill(218,165,32); }
        
      if (type == 4){
        //blue
        fill(72, 209, 204); }
        
    if (shape == 1){
      noStroke();
      if (number == 1){
        ellipse(terrainX1, terrainY1, terrainHeight1, terrainWid1); }
      if (number == 2){
        ellipse(terrainX2, terrainY2, terrainHeight2, terrainWid2); }
    }
    
    if (shape == 2){
      noStroke();
      if (number == 1){
        rect(terrainX1, terrainY1, terrainHeight1, terrainWid1); }
      if (number == 2){
        rect(terrainX2, terrainY2, terrainHeight2, terrainWid2); }
    }
  
   }
   
   

}