import java.util.Random;

class Ball{
  
    //NOTE: When the walls, terrain get too large, the ball bounces off at "invisible" spots
    //So keep the wall, terrain sizes relatively small
    //Make small obstacles and terrain for the levels
  
    //Level determination - to be used later for course generation
    int level = 5;
    
    //ball dimensions and stats 
    float xcor, ycor, radius;
    float xVelocity = 0.0, yVelocity = 0.0;
    float topSpeed = 0.1; //for strokes
    
    //goal dimensions
    float goalX, goalY, goalWidth;
   
    //display variables
    int distance, speed;
    int strokes = 0;
    int totalStrokes = 0;
    int version; 
    
    //for water terrain
    float originalX, originalY;
    
    //constructor
    Ball(float r, float x, float y){
      radius = r;
      xcor = x;
      ycor = y; } 
    
     //float friction (to be implemented later if wanted)
      
     //displaying
     public void displayDist(){
       distance =  int(dist(xcor, ycor, goalX, goalY)); }
       
     public void displaySpeed(){
       //true velocity formula
        speed = int(sqrt( pow(xVelocity, 2) + pow(yVelocity, 2))); }
     
     //this is velocity tolerance for hole
     public boolean isSpeedValid(){
      if (distance <= 200 && speed >= 30){
          return false; }
      return true; }
      
     //most important function
     public void moveBall(){
      xcor += xVelocity;
      ycor += yVelocity; 
      
      xVelocity *= 0.97; //placeholder value for friction... higher value means less friction
      yVelocity *= 0.97; 
      
      //this determines whether ball is in hole or not
      //Added Power to determine if ball is going to fast
      if ( ((dist(xcor, ycor, goalX, goalY) < (radius +goalWidth) * 0.5)) && isSpeedValid()){
        level += 1;
        xVelocity = 0.0;
        yVelocity = 0.0;
        setup(); }
        
      //bounce off edges  
      if (xcor >= width - radius || xcor <= radius){
            xVelocity *= -.95; }
      if (ycor >= height-radius || ycor <= radius){
            yVelocity *= -.95; }
          
      //bouncing off walls    
      if ( 
               
          ( (xcor > obsL1 && xcor < obsR1) && (ycor > obsT1 && ycor < obsB1) ) ||
          ( (xcor > obsL2 && xcor < obsR2) && (ycor > obsT2 && ycor < obsB2) ) ||
          ( (xcor > obsL3 && xcor < obsR3) && (ycor > obsT3 && ycor < obsB3) ) ||
          ( (xcor > obsL4 && xcor < obsR4) && (ycor > obsT4 && ycor < obsB4) ) ||
          ( (xcor > obsL5 && xcor < obsR5) && (ycor > obsT5 && ycor < obsB5) ) ||
          ( (xcor > obsL6 && xcor < obsR6) && (ycor > obsT6 && ycor < obsB6) ) ||
          ( (xcor > obsL7 && xcor < obsR7) && (ycor > obsT7 && ycor < obsB7) ) ){
          else{
            xVelocity *= -.95; 
            yVelocity *= -.95; }
          }    
        
        
      //INTERACTION WITH TERRAIN
      
      if ( 
          
          ( (xcor > terrainL1 && xcor < terrainR1) && (ycor > terrainT1 && ycor < terrainB1) ) ||
          ( (xcor > terrainL2 && xcor < terrainR2) && (ycor > terrainT2 && ycor < terrainB2) ) ||
          ( (xcor > terrainL3 && xcor < terrainR3) && (ycor > terrainT3 && ycor < terrainB3) ) ||
          ( (xcor > terrainL4 && xcor < terrainR4) && (ycor > terrainT4 && ycor < terrainB4) ) ||
          ( (xcor > terrainL5 && xcor < terrainR5) && (ycor > terrainT5 && ycor < terrainB5) ) ||
          ( (xcor > terrainL6 && xcor < terrainR6) && (ycor > terrainT6 && ycor < terrainB6) ) ||
          ( (xcor > terrainL7 && xcor < terrainR7) && (ycor > terrainT7 && ycor < terrainB7) ) ){
               
               
          //depression - adds a boost to ball's speed
          //should work fine, but sometimes ball accelerates even when it's not in the terrain
          if (terrainType1 == 1){
            xVelocity *= 1 + (0.1);
            yVelocity *= 1 + (0.1);  }
          
          
          //sand - slows down ball until speed is 0
          //works fine
          if (terrainType1 == 2){
            if (xVelocity > 1){
              xVelocity -= 1; }
            else{
              xVelocity = 0; }
              
            if (yVelocity > 1){
              yVelocity -= 1; }
            else{
               yVelocity = 0; }
          }
          
          
          //water resets the ball's original coordinates
          //works fine
          if (terrainType1 == 3){
            xcor = originalX;
            ycor = originalY;
            xVelocity = 0.0;
            yVelocity = 0.0; 
            radius = 30.0; }
         }
         
    }
    
    public void drawBall(){
       fill(255);
       noStroke();
       ellipse(xcor, ycor, radius, radius); }
       
       
    //RANDOM COURSE GENERATOR
     public void setup(){
      resetObstacleTerrain();
      strokes = 0;
      xVelocity = 0.0;
      yVelocity = 0.0; 
      radius = 30.0;
      goalWidth = 50.0;
      rectMode(CENTER);
      
     if (level == 1){ 
      int rand;
      Random ran = new Random();
      rand = ran.nextInt(4) + 1;
      
      
      //level 1 version 1
      if (rand == 1){
        version = 1;
        setupStart(150.0, 150.0, width/2, height/2);
        
        //wall and sand
        setupWall(1, 600, 300, 50, 75); 
        drawWall(1); 
        
        terrainX1 = 300;
        terrainY1 = 300;
        terrainH1 = 100;
        terrainW1 = 125;
        terrainType1 = 2;
        drawTerrain(1,2); }   
        
     //level 1 version 2
     if (rand == 2){
         version = 2;
         setupStart(150.0, 675.0, 750, 75);
         
         originalX = 150.0;
         originalY = 675.0; 
         
         //wall and water
         setupWall(1, 725, 150, 90, 75); 
         drawWall(1);
         
         terrainX1 = height/2;
         terrainY1 =  width/2 - 200;
         terrainH1 = 200;
         terrainW1 = 250;
         terrainType1 = 3;
         drawTerrain(1, 3); }
       
      //level 1 version 3 
      if (rand == 3){
          setupStart(50.0, 50.0, 700, 700);
          version = 3;
          
          //wall and depression  
          setupWall(1, height/2 + 50, width/2 + 50, 200, 200);
          drawWall(1);
          
          terrainX1 = 700;
          terrainY1 = 500;
          terrainH1 = 100;
          terrainW1 = 130; 
          terrainType2 = 1;
          drawTerrain(1, 1); }
          
      //level 1 version 4 
      if (rand == 4){
          version = 4;
          setupStart(100.0, 100.0, 725, 100);
          
          //wall and sand
          setupWall(1, 700, 200, 100, 130);
          drawWall(1);
          
          terrainX1 = 600;
          terrainY1 = 50;
          terrainH1 = 150;
          terrainW1 = 115;
          terrainType1 = 2;
          drawTerrain(1, 2); }
          
       terrainL1 = terrainX1 - (terrainW1 / 2);
       terrainR1 = terrainX1 + (terrainW1 / 2);
       terrainT1 = terrainY1 - (terrainH1 / 2);
       terrainB1 = terrainY1 + (terrainH1 / 2); }
     
     
       if (level == 2){
          
        int rand;
        Random ran = new Random();
        rand = ran.nextInt(2) + 1;
        
        //level 2 version 5
        if (rand == 1){
          version = 5;
          setupStart(50.0, 50.0, 450, 350);
        
          //wall and sand
          setupWall(1, 275, 280, 125, 160);
          setupWall(2, 400, 130, 125, 120);
          drawWall(1); 
          drawWall(2); 
          
          terrainX1 = 400;
          terrainY1 = 450;
          terrainH1 = 125;
          terrainW1 = 150;
          terrainType1 = 2; 
          drawTerrain(1,2); }
          
          //level 2 version 6
          if (rand == 2){
            version = 6;
            setupStart(50.0, 50.0, 450, 350);
            originalX = 50.0;
            originalY = 50.0;
            
            setupWall(1, 275, 280, 125, 160);
            setupWall(2, 400, 130, 125, 120);
            drawWall(1);
            drawWall(2);
            
            //water
            terrainX1 = 275;
            terrainY1 = 550;
            terrainH1 = 125;
            terrainW1 = 200; //150
            terrainType1 = 3;
            drawTerrain(1,3); }
            
            terrainL1 = terrainX1 - (terrainW1 / 2);
            terrainR1 = terrainX1 + (terrainW1 / 2);
            terrainT1 = terrainY1 - (terrainH1 / 2);
            terrainB1 = terrainY1 + (terrainH1 / 2); }
            
            
        if (level == 3){
          int rand;
          Random ran = new Random();
          rand = ran.nextInt(2) + 1;
          
          //level 3 version 7
          if (rand == 1){
            version = 7;
            setupStart(50.0, 50.0, 450, 350);
            
            setupWall(1, 275, 280, 125, 120);
            setupWall(2, 400, 130, 125, 120);
            setupWall(3, 400, 450, 125, 120); 
            drawWall(1); 
            drawWall(2); 
            drawWall(3);
            
            originalX = 50.0;
            originalY = 50.0;
            
            terrainX1 = 700;
            terrainY1 = 150;
            terrainH1 = 125;
            terrainW1 = 175;
            terrainType1 = 3;
            
            terrainX2 = 700;
            terrainY2 = 650;
            terrainH2 = 125;
            terrainW2 = 175;
            terrainType2 = 3;
            drawTerrain(1, 3);
            drawTerrain(2, 3); }
            
          //level 3 version 8 - fixed bugs
          if (rand == 2){
            version = 8;
            setupStart(50.0, 50.0, 700, 700);
            
            setupWall(1, 200, 200, 100, 150);
            setupWall(2, 600, 600, 100, 150);
            drawWall(1);
            drawWall(2);
            
            terrainX1 = 800;
            terrainY1 = 200;
            terrainH1 = 150;
            terrainW1 = 100;
            terrainType1 = 2;
            drawTerrain(1, 2);
            
          }
          
          terrainL1 = terrainX1 - (terrainW1 / 2);
          terrainR1 = terrainX1 + (terrainW1 / 2);
          terrainT1 = terrainY1 - (terrainH1 / 2);
          terrainB1 = terrainY1 + (terrainH1 / 2);
          
          terrainL2 = terrainX2 - (terrainW2 / 2);
          terrainR2 = terrainX2 + (terrainW2 / 2);
          terrainT2 = terrainY2 - (terrainH2 / 2);
          terrainB2 = terrainY2 + (terrainH2 / 2);
          
        }
        
        
       if (level == 4){
          int rand;
          Random ran = new Random();
          rand = ran.nextInt(2) + 1;
          
          //level 4 version 9
          if (rand == 1){
            version = 9;
            setupStart(850.0, 750.0, 50, 50); 
            
            setupWall(1, 100, 200, 125, 100);
            setupWall(2, 400, 100, 150, 125);
            setupWall(3, 750, 350, 150, 150);
            drawWall(1);
            drawWall(2);
            drawWall(3);
            
            terrainX1 = 500;
            terrainY1 = 500;
            terrainH1 = 125;
            terrainW1 = 125;
            terrainType1 = 2;
            drawTerrain(1,2); }
            
          //level 4 version 10  
          if (rand == 2){
            version = 10;
            setupStart(50.0, 700.0, 800, 100);
            
            setupWall(1, 500, 75, 110, 130);
            setupWall(2, 650, 200, 150, 125);
            setupWall(3, 600, 600, 180, 180);
            drawWall(1);
            drawWall(2);
            drawWall(3); 
            
            //water
            originalX = 50.0;
            originalY = 700.0;
            terrainX1 = 350;
            terrainY1 = 450;
            terrainH1 = 150;
            terrainW1 = 165;
            terrainType1 = 3;
            drawTerrain(1, 3); }
            
          terrainL1 = terrainX1 - (terrainW1 / 2);
          terrainR1 = terrainX1 + (terrainW1 / 2);
          terrainT1 = terrainY1 - (terrainH1 / 2);
          terrainB1 = terrainY1 + (terrainH1 / 2); }
          
          
       if (level == 5){
          int rand;
          Random ran = new Random();
          rand = ran.nextInt(3) + 1;
          
          //level 5 version 11
          if (rand == 1){
            version = 11;
            setupStart(50.0, 600.0, 800, 100);
            setupWall(1, 300, 150, 150, 150);
            setupWall(2, 450, 700, 175, 125);
            setupWall(3, 600, 500, 200, 200);
            setupWall(4, 750, 300, 135, 145);
            drawWall(1);
            drawWall(2);
            drawWall(3);
            drawWall(4);
            
            terrainX1 = 500;
            terrainY1 = 250;
            terrainH1 = 135;
            terrainW1 = 150;
            terrainType1 = 1;
            drawTerrain(1,1); }
            
         //level 5 version 12
         if (rand == 2){
           version = 12;
           setupStart(125.0, 500.0, 600, 100);
           setupWall(1, 200, 200, 125, 125);
           setupWall(2, 300, 500, 150, 150);
           setupWall(3, 400, 300, 130, 140);
           setupWall(4, 650, 700, 165, 175);
           drawWall(1);
           drawWall(2);
           drawWall(3);
           drawWall(4);
           
           originalX = 125.0;
           originalY = 500.0;
           terrainX1 = 700; 
           terrainY1 = 250;
           terrainH1 = 115;
           terrainW1 = 125;
           terrainType1 = 3;
           drawTerrain(1,3); } 
           
         //level 5 version 13
         if (rand == 3){
           version = 13;
           setupStart(125.0, 500.0, 600, 100);
           setupWall(1, 250, 250, 125, 125);
           setupWall(2, 350, 550, 150, 150);
           setupWall(3, 450, 350, 130, 140);
           setupWall(4, 700, 750, 165, 175);
           drawWall(1);
           drawWall(2);
           drawWall(3);
           drawWall(4);
           
           terrainX1 = 700;
           terrainY1 = 250;
           terrainH1 = 115;
           terrainW1 = 125;
           terrainType1 = 2;
           drawTerrain(1,2); }
           
          terrainL1 = terrainX1 - (terrainW1 / 2);
          terrainR1 = terrainX1 + (terrainW1 / 2);
          terrainT1 = terrainY1 - (terrainH1 / 2);
          terrainB1 = terrainY1 + (terrainH1 / 2);
          
       }
       
       
       if (level == 6){
          int rand;
          Random ran = new Random();
          rand = ran.nextInt(2) + 1;
          
          //level 6 version 14
          if (rand == 1){
            version = 14;
            setupStart(50.0, 50.0, 750, 750);
            setupWall(1, 150, 150, 175, 150);
            setupWall(2, 750, 150, 125, 175);
            setupWall(3, 600, 700, 150, 150);
            setupWall(4, 750, 550, 175, 175);
            drawWall(1);
            drawWall(2);
            drawWall(3);
            drawWall(4);
            
            originalX = 50.0;
            originalY = 50.0; 
            terrainX1 = 450;
            terrainY1 = 450;
            terrainH1 = 145;
            terrainW1 = 145;
            terrainType1 = 3;
            drawTerrain(1, 3);
            
            terrainX2 = 450;
            terrainY2 = 700;
            terrainH2 = 125;
            terrainW2 = 135;
            terrainType2 = 2;
            drawTerrain(2, 2); }
            
         //level 6 version 15   
         if (rand == 2){
           version = 15;
           setupStart(50.0, 50.0, 750, 750); 
           setupWall(1, 150, 125, 125, 175);
           setupWall(2, 300, 325, 125, 175);
           setupWall(3, 600, 375, 125, 125);
           setupWall(4, 200, 650, 150, 150);
           drawWall(1);
           drawWall(2);
           drawWall(3);
           drawWall(4); 
            
           terrainX1 = 500;
           terrainY1 = 575;
           terrainH1 = 130;
           terrainW1 = 115;
           terrainType1 = 1;
           drawTerrain(1,1);
           
           terrainX2 = 675;
           terrainY2 = 650;
           terrainH2 = 130;
           terrainW2 = 115;
           terrainType2 = 2;
           drawTerrain(2,2); }
           
           terrainL1 = terrainX1 - (terrainW1 / 2);
           terrainR1 = terrainX1 + (terrainW1 / 2);
           terrainT1 = terrainY1 - (terrainH1 / 2);
           terrainB1 = terrainY1 + (terrainH1 / 2);
          
           terrainL2 = terrainX2 - (terrainW2 / 2);
           terrainR2 = terrainX2 + (terrainW2 / 2);
           terrainT2 = terrainY2 - (terrainH2 / 2);
           terrainB2 = terrainY2 + (terrainH2 / 2);
           
     }
     
     
   }
       
            
    public void draw(){
       background(50,205,50);
       moveBall();
       
       fill (120, 120, 120); //this is the hole
       ellipse(goalX, goalY, goalWidth, goalWidth); 
       
       drawWall(1);
       drawWall(2);
       drawWall(3);
       drawWall(4);
       drawWall(5);
       drawWall(6);
       drawWall(7);
       
       //drawTerrain(int number, int type)
       if (version == 1){
         drawTerrain(1,2); }
         
       if (version == 2){
         drawTerrain(1,3); }
         
       if (version == 3){
         drawTerrain(1,1); }
         
       if (version == 4){
         drawTerrain(1,2); }
         
       if (version == 5){
         drawTerrain(1,2); }
         
       if (version == 6){
         drawTerrain(1,3); }
         
       if (version == 7){
         drawTerrain(1,3);
         drawTerrain(2,3); }
         
       if (version == 8){
         drawTerrain(1,2); }
         
       if (version == 9){
         drawTerrain(1,2); }
         
       if (version == 10){
         drawTerrain(1,3); }
         
       if (version == 11){
         drawTerrain(1,1); }
         
       if (version == 12){
         drawTerrain(1,3); }
         
       if (version == 13){
         drawTerrain(1,2); }
         
       if (version == 14){
         drawTerrain(1,3);
         drawTerrain(2,2); }
         
       if (version == 15){
         drawTerrain(1,1);
         drawTerrain(2,2); } 
         
       
       drawBall();
       
       text("Strokes: " + strokes, 25, 25); //display stroke count
       text("Total Strokes: " + totalStrokes, 125, 25); //display total strokes
       text("Level: " + level, 25, 50); //display stroke count
       text("Version: " + version, 25, 75); //display version of level
       text("Distance to Goal: " + distance, 25, 100); //for testing purposes
       text("Ball Speedometer: " + speed, 25, 125); //for testing purposes

    }
        
   public void mousePressed(float power){
          
        if (mousePressed == true){
          float currentSpeed = dist(0.0, 0.0, xVelocity, yVelocity);
          if (currentSpeed > topSpeed){
            return; }
          strokes += 1;  //update stroke count
          totalStrokes += 1; //update total stroke count
        
          float angleToMouse = atan2(pmouseY - ycor, pmouseX - xcor);
          float ballSpeed = power; 
          xVelocity = cos(angleToMouse) * ballSpeed;
          yVelocity = sin(angleToMouse) * ballSpeed; }
    }
    
    //obstacle variables     
    int obstacleType = 0; //default 0 is brick wall, we'll add more if we have time
    int obsX1, obsY1, obsH1, obsW1, obsL1, obsR1, obsT1, obsB1;
    int obsX2, obsY2, obsH2, obsW2, obsL2, obsR2, obsT2, obsB2; 
    int obsX3, obsY3, obsH3, obsW3, obsL3, obsR3, obsT3, obsB3; 
    int obsX4, obsY4, obsH4, obsW4, obsL4, obsR4, obsT4, obsB4; 
    int obsX5, obsY5, obsH5, obsW5, obsL5, obsR5, obsT5, obsB5; 
    int obsX6, obsY6, obsH6, obsW6, obsL6, obsR6, obsT6, obsB6; 
    int obsX7, obsY7, obsH7, obsW7, obsL7, obsR7, obsT7, obsB7; 
   
   
    public void setupStart(float x, float y, int gx, int gy){
      xcor = x;
      ycor = y; 
      goalX = gx;
      goalY = gy; }
      
   
    public void setupWall(int num, int x, int y, int h, int w){
      
      rectMode(CENTER);
      
      if (num == 1){
        obsX1 = x;
        obsY1 = y;
        obsH1 = h;
        obsW1 = w; 
        obsL1 = x - (w/2);
        obsR1 = x + (w/2);
        obsT1 = y - (h/2);
        obsB1 = y + (h/2); } 
        
      if (num == 2){
        obsX2 = x;
        obsY2 = y;
        obsH2 = h;
        obsW2 = w; 
        obsL2 = x - (w/2);
        obsR2 = x + (w/2);
        obsT2 = y - (h/2);
        obsB2 = y + (h/2); } 
        
      if (num == 3){
        obsX3 = x;
        obsY3 = y;
        obsH3 = h;
        obsW3 = w; 
        obsL3 = x - (w/2);
        obsR3 = x + (w/2);
        obsT3 = y - (h/2);
        obsB3 = y + (h/2); } 
        
      if (num == 4){
        obsX4 = x;
        obsY4 = y;
        obsH4 = h;
        obsW4 = w;
        obsL4 = x - (w/2);
        obsR4 = x + (w/2);
        obsT4 = y - (h/2);
        obsB4 = y + (h/2); } 
        
      if (num == 5){
        obsX5 = x;
        obsY5 = y;
        obsH5 = h;
        obsW5 = w; 
        obsL5 = x - (w/2);
        obsR5 = x + (w/2);
        obsT5 = y - (h/2);
        obsB5 = y + (h/2); } 
        
      if (num == 6){
        obsX6 = x;
        obsY6 = y;
        obsH6 = h;
        obsW6 = w; 
        obsL6 = x - (w/2);
        obsR6 = x + (w/2);
        obsT6 = y - (h/2);
        obsB6 = y + (h/2); } 
        
      if (num == 7){
        obsX7 = x;
        obsY7 = y;
        obsH7 = h;
        obsW7 = w; 
        obsL7 = x - (w/2);
        obsR7 = x + (w/2);
        obsT7 = y - (h/2);
        obsB7 = y + (h/2); }
      
    }
      
    public void drawWall(int number){
     fill(220,20,60); //crimson
     noStroke();
     rectMode(CENTER);
     if (number == 1){
       rect(obsX1, obsY1, obsH1, obsW1); }
     if (number == 2){
       rect(obsX2, obsY2, obsH2, obsW2); }
     if (number == 3){
       rect(obsX3, obsY3, obsH3, obsW3); }
     if (number == 4){
       rect(obsX4, obsY4, obsH4, obsW4); }
     if (number == 5){
       rect(obsX5, obsY5, obsH5, obsW5); }
     if (number == 6){
       rect(obsX6, obsY6, obsH6, obsW6); }
     if (number == 7){
       rect(obsX7, obsY7, obsH7, obsW7); }
     }
     
    
    //terrain variables
    int terrainX1, terrainY1, terrainH1, terrainW1, terrainType1, terrainL1, terrainR1, terrainT1, terrainB1; 
    int terrainX2, terrainY2, terrainH2, terrainW2, terrainType2, terrainL2, terrainR2, terrainT2, terrainB2;
    int terrainX3, terrainY3, terrainH3, terrainW3, terrainType3, terrainL3, terrainR3, terrainT3, terrainB3;
    int terrainX4, terrainY4, terrainH4, terrainW4, terrainType4, terrainL4, terrainR4, terrainT4, terrainB4;
    int terrainX5, terrainY5, terrainH5, terrainW5, terrainType5, terrainL5, terrainR5, terrainT5, terrainB5;
    int terrainX6, terrainY6, terrainH6, terrainW6, terrainType6, terrainL6, terrainR6, terrainT6, terrainB6;
    int terrainX7, terrainY7, terrainH7, terrainW7, terrainType7, terrainL7, terrainR7, terrainT7, terrainB7;
   
   
    // 1 - depression(light green), 2 - sand, 3 - water    
    // for shape -> 1 - rect, if we have more time we'll add more shapes later rect
    public void drawTerrain(int number, int type){
          
        if (type == 1){
          //light green
          fill(144,238,144); }
          
        if (type == 2){
          //golden
          fill(218,165,32); }
          
        if (type == 3){
          //blue
          fill(72, 209, 204); }
        
        noStroke();
        rectMode(CENTER);
        if (number == 1){
          rect(terrainX1, terrainY1, terrainH1, terrainW1); }
        if (number == 2){
          rect(terrainX2, terrainY2, terrainH2, terrainW2); }
        if (number == 3){
          rect(terrainX3, terrainY3, terrainH3, terrainW3); }
        if (number == 4){
          rect(terrainX4, terrainY4, terrainH4, terrainW4); }
        if (number == 5){
          rect(terrainX5, terrainY5, terrainH5, terrainW5); }
        if (number == 6){
          rect(terrainX6, terrainY6, terrainH6, terrainW6); }
        if (number == 7){
          rect(terrainX7, terrainY7, terrainH7, terrainW7); }
    
     }
     
     public void resetObstacleTerrain(){
       obsX1 = 0;
       obsY1 = 0;
       obsH1 = 0;
       obsW1 = 0;
       obsL1 = 0;
       obsR1 = 0;
       obsT1 = 0;
       obsB1 = 0;
       
       obsX2 = 0;
       obsY2 = 0;
       obsH2 = 0;
       obsW2 = 0;
       obsL2 = 0;
       obsR2 = 0;
       obsT2 = 0;
       obsB2 = 0;
       
       obsX3 = 0;
       obsY3 = 0;
       obsH3 = 0;
       obsW3 = 0;
       obsL3 = 0;
       obsR3 = 0;
       obsT3 = 0;
       obsB3 = 0;
       
       obsX4 = 0;
       obsY4 = 0;
       obsH4 = 0;
       obsW4 = 0;
       obsL4 = 0;
       obsR4 = 0;
       obsT4 = 0;
       obsB4 = 0;
       
       obsX5 = 0;
       obsY5 = 0;
       obsH5 = 0;
       obsW5 = 0;
       obsL5 = 0;
       obsR5 = 0;
       obsT5 = 0;
       obsB5 = 0;
       
       obsX6 = 0;
       obsY6 = 0;
       obsH6 = 0;
       obsW6 = 0;
       obsL6 = 0;
       obsR6 = 0;
       obsT6 = 0;
       obsB6 = 0;
       
       obsX7 = 0;
       obsY7 = 0;
       obsH7 = 0;
       obsW7 = 0;
       obsL7 = 0;
       obsR7 = 0;
       obsT7 = 0;
       obsB7 = 0;
       
       terrainX1 = 0;
       terrainY1 = 0;
       terrainH1 = 0;
       terrainW1 = 0;
       terrainType1 = 0;
       terrainL1 = 0;
       terrainR1 = 0;
       terrainT1 = 0;
       terrainB1 = 0;
       
       terrainX2 = 0;
       terrainY2 = 0;
       terrainH2 = 0;
       terrainW2 = 0;
       terrainType2 = 0;
       terrainL2 = 0;
       terrainR2 = 0;
       terrainT2 = 0;
       terrainB2 = 0;
       
       terrainX3 = 0;
       terrainY3 = 0;
       terrainH3 = 0;
       terrainW3 = 0;
       terrainType3 = 0;
       terrainL3 = 0;
       terrainR3 = 0;
       terrainT3 = 0;
       terrainB3 = 0;
       
       terrainX4 = 0;
       terrainY4 = 0;
       terrainH4 = 0;
       terrainW4 = 0;
       terrainType4 = 0;
       terrainL4 = 0;
       terrainR4 = 0;
       terrainT4 = 0;
       terrainB4 = 0;
       
       terrainX5 = 0;
       terrainY5 = 0;
       terrainH5 = 0;
       terrainW5 = 0;
       terrainType5 = 0;
       terrainL5 = 0;
       terrainR5 = 0;
       terrainT5 = 0;
       terrainB5 = 0;
       
       terrainX6 = 0;
       terrainY6 = 0;
       terrainH6 = 0;
       terrainW6 = 0;
       terrainType6 = 0;
       terrainL6 = 0;
       terrainR6 = 0;
       terrainT6 = 0;
       terrainB6 = 0;
       
       terrainX7 = 0;
       terrainY7 = 0;
       terrainH7 = 0;
       terrainW7 = 0;
       terrainType7 = 0;
       terrainL7 = 0;
       terrainR7 = 0;
       terrainT7 = 0;
       terrainB7 = 0;
       
     } 
   
  
}
