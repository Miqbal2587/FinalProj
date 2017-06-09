class Ball{

  //THINGS TO FIX:
  //1 - KEEP TESTING VELOCITY TOLERANCE RANGE WHEN BALL ENTERS HOLE (IF TOO FAST, BALL WILL GO OVER);
  //2 - FINE TUNE THE BALL'S INTERACTION WITH OBSTACLES
  
  // 6/8 UPDATE
  //3 - FINE TUNE BALL'S INTERACTION WITH TERRAIN
  
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
  
  //constructor
  Ball(float r, float x, float y){
    radius = r;
    xcor = x;
    ycor = y; } 
  
   // float friction (to be implemented later)
    
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
    
    //sample terrain
    //terrain types 1 - elevation, 2 - depression, 3 - sand, 4 - water  
    //setupTerrain(int number, int type, int size, int difficulty)
    //drawTerrain(int number, int type, int shape)
    
    setupTerrain(1,1,2,3); 
    drawTerrain(1,1,1); }
    
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
    if (xpos >= width - radius || xpos <= radius){
          //placeholder values
          xVelocity = xVelocity * -.95; }
    if (ypos >= height-radius || ypos <= radius){
          yVelocity= yVelocity * -.95; }
        
    //work on bouncing off wall/obstacle
    if ((xpos <= obsX1 + obsWid1 && xpos >= obsX1) && (ypos <= obsY1 + obsHeight1 && ypos >= obsY1)){
      xVelocity *= -.95; 
      yVelocity *= -.95; }    
      
      
    //INTERACTION WITH TERRAIN
    
    //BUG - THIS ONLY WORKS FOR RECTANLES, ADJUST FOR CIRCLES LATER
    //BUG - *** Ball gets affcted even though it's not touching terrain, work on adjusting coordinates later
    if ((xpos <= terrainX1 + terrainWid1 && xpos >= terrainX1) && 
      (ypos <= terrainY1 + terrainHeight1 && ypos >= terrainY1)){
        
        //elevation - continually reverses ball's velocity (speeds down, then speeds up other way)
        //this has many bugs, WORK ON COMPLETELY REVERSING BALL'S DIRECTION RATHER THAN DEFLECTING
     
        
        if (terrainType1 == 1){
         
          //if ball is well inside the hill and not fast enough, reverse direction   
          if ((xpos <= terrainX1 + terrainWid1 - terrainWid1/4.0 && xpos >= terrainX1 + terrainWid1/4.0) && 
              (ypos <= terrainY1 + terrainHeight1 - terrainHeight1/4.0 && ypos >= terrainY1 + terrainHeight1/4)){
                
                //placeholder value for "min" speed to go over hill
                if (speed <= 15){
                  xVelocity *= -.95;
                  yVelocity *= -.95; }
            
           }
           
           else{
              //keep slowing down until you reach top of hill
              if (xVelocity > 0){
                xVelocity -= terrainMod1; }
                
              if (yVelocity > 0){
                yVelocity -= terrainMod1; }
            }
    
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
     
     //drawTerrain(int number, int type, int shape)
     drawTerrain(1,1,1);
     
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
  int obsX2, obsY2, obsHeight2, obsWid2;
  int obsX3, obsY3, obsHeight3, obsWid3;
  int obsX4, obsY4, obsHeight4, obsWid4;
  int obsX5, obsY5, obsHeight5, obsWid5;
  int obsX6, obsY6, obsHeight6, obsWid6;
  int obsX7, obsY7, obsHeight7, obsWid7;
 
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
  int terrainX1, terrainY1, terrainHeight1, terrainWid1, terrainMod1, terrainType1; //refers to each instance of a terrain
  int terrainX2, terrainY2, terrainHeight2, terrainWid2, terrainMod2, terrainType2;
  int terrainX3, terrainY3, terrainHeight3, terrainWid3, terrainMod3, terrainType3;
  int terrainX4, terrainY4, terrainHeight4, terrainWid4, terrainMod4, terrainType4;
  int terrainX5, terrainY5, terrainHeight5, terrainWid5, terrainMod5, terrainType5;
  int terrainX6, terrainY6, terrainHeight6, terrainWid6, terrainMod6, terrainType6;
  int terrainX7, terrainY7, terrainHeight7, terrainWid7, terrainMod7, terrainType7;
 
 
  //number refers to the instance of the terrain
  //type refers to type of terrain
  //for size -> 1 - small, 2 - medium, 3 - large
  //the higher the difficulty, the more it will affect the ball's velocity
  public void setupTerrain(int number, int type, int size, int difficulty){
  
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
        
      if (number == 3){
        terrainX3 = 200;
        terrainY3 = 200;
        terrainHeight3 = 35 * size;
        terrainWid3 = 45 * size;
        terrainMod3 = difficulty; 
        terrainType3 = type; }
        
      if (number == 4){
        terrainX4 = 200;
        terrainY4 = 200;
        terrainHeight4 = 35 * size;
        terrainWid4 = 45 * size;
        terrainMod4 = difficulty; 
        terrainType4 = type; }
        
      if (number == 5){
        terrainX5 = 200;
        terrainY5 = 200;
        terrainHeight5 = 35 * size;
        terrainWid5 = 45 * size;
        terrainMod5 = difficulty; 
        terrainType5 = type; }
        
      if (number == 6){
        terrainX6 = 200;
        terrainY6 = 200;
        terrainHeight6 = 100 * size;
        terrainWid6 = 125 * size;
        terrainMod6 = difficulty; 
        terrainType6 = type; }
        
      if (number == 7){
        terrainX7 = 200;
        terrainY7 = 200;
        terrainHeight7 = 35 * size;
        terrainWid7 = 45 * size;
        terrainMod7 = difficulty; 
        terrainType7 = type; }
        
  }
        
  //velocity will be affected in the ball's move function
   
  //terrain types 1 - elevation(dark green), 2 - depression(light green), 3 - sand, 4 - water    
  //for shape -> 1 - ellipse, 2 - rect (basic shapes, add more later)   
  public void drawTerrain(int number, int type, int shape){
    
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
        rect(terrainX1, terrainY1, terrainHeight1, terrainWid1); }
      if (number == 2){
        rect(terrainX2, terrainY2, terrainHeight2, terrainWid2); }
      if (number == 3){
        rect(terrainX3, terrainY3, terrainHeight3, terrainWid3); }
      if (number == 4){
        rect(terrainX4, terrainY4, terrainHeight4, terrainWid4); }
      if (number == 5){
        rect(terrainX5, terrainY5, terrainHeight5, terrainWid5); }
      if (number == 6){
        rect(terrainX6, terrainY6, terrainHeight6, terrainWid6); }
      if (number == 7){
        rect(terrainX7, terrainY7, terrainHeight7, terrainWid7); }
    }
    
    if (shape == 2){
      noStroke();
      if (number == 1){
        ellipse(terrainX1, terrainY1, terrainHeight1, terrainWid1); }
      if (number == 2){
        ellipse(terrainX2, terrainY2, terrainHeight2, terrainWid2); }
      if (number == 3){
        ellipse(terrainX3, terrainY3, terrainHeight3, terrainWid3); }
      if (number == 4){
        ellipse(terrainX4, terrainY4, terrainHeight4, terrainWid4); }
      if (number == 5){
        ellipse(terrainX5, terrainY5, terrainHeight5, terrainWid5); }
      if (number == 6){
        ellipse(terrainX6, terrainY6, terrainHeight6, terrainWid6); }
      if (number == 7){
        ellipse(terrainX7, terrainY7, terrainHeight7, terrainWid7); }
    }
  
   }
   
   
   //BEGIN RANDOM COURSE GENERATOR - LEVEL 1
   public void setup1(){
    strokes = 0;
    xVelocity = 0.0;
    yVelocity = 0.0; 
    radius = 30.0;
    goalWidth = 50.0;
    
    int rand;
    rand = int(random(0,5)); //4 possible ways
    
    //just some random values
    if (rand == 0){
      xcor = 150.0;
      ycor = 150.0;
      goalX = width/2;
      goalY = height/2; }
      
    if (rand == 1){
      xcor = 450.0;
      ycor = 450.0;
      goalX = 50.0;
      goalY = 50.0; }
      
    if (rand == 2){
      xcor = 450.0;
      ycor = 150.0;
      goalX = 25.0;
      goalY = 600.0; }
      
    if (rand == 3){
      xcor = 150.0;
      ycor = 450.0; 
      goalX = width/2 + 300;
      goalY = height/2 + 300; }
      
    
  
    goalX = width/2;
    goalY = height/2; 
    
    
    
    //sample wall obstacle
    setupWall();
    drawWall();
    
    //sample terrain
    //terrain types 1 - elevation, 2 - depression, 3 - sand, 4 - water  
    //setupTerrain(int number, int type, int size, int difficulty)
    //drawTerrain(int number, int type, int shape)
    
    setupTerrain(1,1,2,3); 
    drawTerrain(1,1,1); }
    
   
   
   

}