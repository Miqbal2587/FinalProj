#FinalProj 
The gist: Use physics to create a 2D mini golf course. The player will use his or her knowledge of physics and control the ball’s velocity into the hole. Various obstacles and course dimensions will be generated semi randomly as each level progresses in relative difficulty. 

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


