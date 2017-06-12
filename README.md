#FinalProj 
The gist: Create a 2D mini golf course. The player will control the ball’s velocity into the hole. Various obstacles and course terrain will be generated semi randomly as each level progresses in relative difficulty. 

Refer to instructions and features below the developmental log

Developmental log:

5/27 - 6/2:  Original idea was to create a stock analysis program and stock market game. This lofty idea had to be scrapped due to difficulty fetching real time stock data from online sources and csv files of historical stock data. Original files meant to retrieve data via API and  can be found in the commit logs. We established a new prototype and started the mini golf project from this point on.

6/3: No files added, learning and getting used to the processing sytnax and looking at sample library files to see how physics and visual displays are implemented. 

6/4: Added basic files MiniGolf (the primary visual displayer that updates itself) and class Ball. This is a very crude implementation as the ball only moves from each click. The ball needs to be continually rolling after a mouse click until friction completely slows it down. We also tried to add a template Course class but this needs to be fixed.

6/5: UPDATE
Significant improvements made on basic game mechanics.
Features added:
1) Release ball based on where mouse was clicked
2) Added friction so the ball doesn't move continually
3) Added a hole into the course and way to determine whether the ball is in the hole

6/7: UPDATE
Fixed bug - the ball now bounces off the walls with reduced speed 
1) Added user input power - Hover over the slider named Power and mouse scroll over it to adjust power
2) Added min velocity in which ball goes too fast, it will go over the hole without going in
3) Added first obstacle type - brick wall - in which the ball bounces off of

6/8: UPDATE
1) Added terrain types elevation, depression, sand, and water
2) Began working on random course generation, so far only works for level 1
Made major strides today

6/9: Things to add
1) Start working on progressing up levels and begin level 2
2) Fine tune the random course generator
3) Add more shape types for terrains and obstacles
4) Begin working on new obstacle types
5) Keep testing the terrains and debug anything if neccesary

6/9 - 6/10: MAJOR UPDATE
-Many original ideas had to be scrapped: more obstacle and terrain types, different terrain shapes
-This was due to unexpected bugs that derailed the basic program. These bugs occured when large terrain sizes and obstacles were generated. Also, the ball had difficulty interacting with other shape types besides rectangle, which would destroy the purpose of the game
-To the best of our ability, we can only now focus on generating simple levels with small terrains and walls. Our final commit will include a moderate batch of semi random levels. 
-Things added: Level progression system, fixed weird bouncing with walls. The ball is still a little buggy when it bounces off the window edge

6/11: THE FINAL COMMIT
Things added: bug fixes with bouncing mechanics and added all 9 levels! There are 21 different possible courses that can be generated
1) Unresolved bug: in some cases when the ball gets in the hole and progresses to the next level, the ball retains its velocity and continues moving throughout the start of the next course
2) Unresolved bug: we wanted to display "You win" on the screen after beating the final level, but the game was unable to load the screen
3) Features that were scrapped: moving obstacle types, elevation/hill terrain type, display something cool after a hole in one
4) Note: bouncing off edges and brick walls are still buggy sometimes, we weren't able to fully resolve this

INSTRUCTIONS 
1) Use your mouse scroller to adjust the power of your swing.. be careful! If you swing too hard when close to the hole, the ball will go right over it
2) Click on the course where you want the ball's velocity to be directed towards to get the ball in its optimal position to reach the hole
3) There are a total of 9 stages. The final level is rather tricky. Have fun!

FEATURES
1) Light green terrain - depression -> the ball will receieve a speed boost
2) Yellow terrain - sand -> the ball will slow down
3) Blue terrain - water -> the ball will reset to its initial coordinates
4) Red obstacle - brick wall -> the ball will bounce off opposite the direction in which it collided with the wall


