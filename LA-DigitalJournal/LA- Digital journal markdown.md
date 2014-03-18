####Laura Abondano
####AGENT-BASED SIMULATION MODELING IN EVOLUTIONARY ANTHROPOLOGY

#DIGITAL JOURNAL

__________________________________________________________________
###Jan 21, 2014 - Homework Assignment 1 - Exploring Cellular Automata

####I. 1D Cellular Automata

1. Can you see any patterns or categories in different types of behavior that are emerging? Describe these patterns. 
	- Repetitive, geometric patterns
- Pattern moves diagonally, vertically or horizontally, but in a straight line. No twirls or curves. 

2. Yay! Got it on the 1st try: Rule #110. Did it looking at the samples in the worksheet, that way I figured out which rules resulted on the next pixel being ON and which ones resulted in the next pixel being OFF. 

This is what is known as a Wolfram's class 4 behavior which is nor completely random nor completely repetitive. 

3. I found out that if you have the completely opposite pattern, if you just switch the ONs to OFFs and vice versa, you won't get the inverse pattern.
- If you make the screen large enough, the pattern will continue repeating vertically.
- There is more than one combination of rules that can result in the same pattern. 

For the first image I found that combinations #165, #167 (table below) and #181 give the same pattern. This is because the 001 and 100 rules do not affect the outcome pattern because this combination of pixels does not appear on the screen.
For the second image. Also got this one on the first try!. Combination #99.
Third image. Also got this one on the first try!. Combination #193.
For the images in question 3 I started doing it randomly because I couldn't really see the pixels in the worksheet, but then I realized I could zoom in the PDF. After I realized this, I simply zoomed in the images and figured out what the next generation outcome would be  from previous cells, and with this a figured out the combination of rules for each pattern. Once I realized that I could zoom in it was pretty easy and got the patterns on the first try. 

4. Rule #30 sort of shows a similar pattern to the molluscs in the image. 
This pattern is known as a Wolfram's class 3 behavior which shows that a simple input pattern can result in what seems to be a random outcome. However, I can't really see the difference between class 3 and class 4, because both seem to be not totally random but not totally repetitive. Rule #30 and rule #110 (question 1) look pretty similar to me, so I don't understand why they are considered as different class types. 

####II. 2D Cellular Automata

1. Does the run eventually reach a steady state? If so, what "still life" and "oscillator" shapes are formed? Repeat this process several times. Are any"gliders"or other spaceships formed?
Yes. On the 1st random setup the run reached a steady state after 1271 generations/ticks.
The oscillators created here are all of the type. During this run there were several gliders and other spaceships, but after it reached a steady state the spaceships disappeared. 

The spaceships in the "Gun" folder shows some glider-guns that generate gliders from four different corners and then these guns merge to create a spaceship that glides towards the right of the screen. 

The golly-ticker in the "Guns" folder is fun too. Guns at the right create gliders that start moving left towards a "static" cluster while creating the word GOLLY. When the word GOLLY reaches the "static" cluster on the left, the letter starts disappearing. 

The puffer-train begins with just a few gliders that then it start making new gliders that spread out towards the right of the screen, and at the end of it when it stabilizes is a"train" made up of blocks, beehives, boats and blinkers. The starting cells are like a spaceship that keep going right creating more and more gliders (glider-gun) which in turn make the rest of the "train" (which looks more like a sword). 


_____________________________________________________________
###Jan 29, 2014 - Homework Assignment 2 - Beginning with NetLogo

Zombies apocalypse!!!

Challenges and what I learned doing the zombie apocalypse model: 

1.	If your world is too big, you can change the patch size in the settings button so you can visualize the entire world and not only a section of it. However, it is easier to try your model in a world with smaller dimensions because it works faster. I did this model with a smaller world and then made it 201 X 201. The problem was that when I made it larger, the agents looked really really tiny so I increased the size of the agents so I could visualize them. 
2.	Order counts. NetLogo works in the order you give the commands, so it is really important to be careful with the order you type things so the model does what you want it to do. 
3.	When you create new agents, you have to assign a singular and plural name for it. For example, to breed humans I types "breed [humans human]". This makes a difference later in the code, and you have to be careful whether you are using the plural or singular term. When you refer to the singular term, you have to tell the model to which specific agent you are referring (e.g. "human 127").
4.	In the "to go" setting you specify what you want your agents to do. To do this you type "ask agent" and then you give a function that you code afterwards. On that new code there is no need to write"ask agent" again because it would be a duplication of the process. For example, I was initially writing the following:

		to go
  		ask zombies [zombies-chase]
		end

and then I would ask zombies again in the zombies-chase code:

	to zombies-chase
  	ask zombies
  	[
    ifelse any? humans in-radius zombie-vision-radius 
    [
      set heading (towards min-one-of humans [distance myself])
      fd zombie-speed
      ]
    [rt random 360
     fd zombie-speed]
   	]
	end

Then I realized that I don't have to write the "ask zombies" inside the"to zombies-chase" command (highlighted in yellow), since I already specified above in the "to go" section, that the zombies-chase command is specific for the zombies breed. This makes the model go way slower since it's making the code run twice every time since you are asking zombies to do this twice. 
5.	When using the patch-here command, I had to write"-on" after the agent so it worked. For example: Human-on patch-here. Didn't know that I had to add the "-on". 
6.	As you increase the number of agents (initial number or the number that is created by the model afterwards), the model starts working slower. Don't know how to fix this (other than moving the speed slider). 
7.	I learned how to make new shapes! pretty cool! Zombies look like zombies, people look like people.
8.	On my zombie apocalypse model, humans always survive!!! This is because I don't have anything that kills humans (other than zombies), as opposed to zombies who die when they haven't eaten any brains after a number of ticks. 
9.	It is very useful to change colors to see new individuals that are created by the model, otherwise it would be hard to tell whether the model is actually doing what I'm telling it to do or not. For example, in my model I had zombies red and humans green, but when a human turned into a zombie, instead of being red, it was orange. This allowed me to see easily when new agents were created by the model and keep track of their settings to check whether they died after x number of ticks or not. 
10.	There's a bunch of websites that are really helpful, as well as the built-in model for zombies on NetLogo. Many people are interested in zombies¦ 


_________________________________________________________________
###Feb 5, 2014 - Working with the ODD Protocol

I found quite challenging trying to write up the ODD protocol for both the Pepper & Smuts (2000) and for my own project. It was hard because I thought it was very repetitive, specially in the Pepper and Smuts example, there were many things that I wrote on the state variables of the entities that I felt like I had to repeat again on the Process overview and scheduling, and again on the initialization section. 

Also, I used the  example of an ODD in the paper from Grimm et al. 2006 to help me understand the concepts, or what I was supposed to include in each section. However, on this example there were somethings that I found not to be consistent with the ODD protocol, or that were overly simplistic and did not explain the model fully. For example, I thought that the Process overview and scheduling from that example didn't fully explain all the procedural steps that were supposed to be on the model. When writing my process overview for the Pepper and Smuts model I thought mine was way too long compared with the example from Grimm et al. (2006), so I don't know whether on an actual paper you are supposed to keep it short, or leave it as detailed as possible and maybe include it in the supplementary material. 

The hardest section of the assignment was definitely trying to write up my own model, which at this point I believe it doesn't really make much sense. I don't know whether it is because I am trying to include too many variables or whether I still haven't figured out the connections between variables and I am making things too complicated! I keep thinking on trying to make the model simpler, taking some of the variables out, for example, genetic structure of the group, or a genetic signal to determine whether relatedness influences the dispersal patterns in this species... but I don't know whether this is going to mess up things since I believe it is an important element on the model. I also think that maybe I am trying to explain an entire species' social behavior, and maybe I should be more specific and focus on only one thing... but the problem is I think all of the variables are somehow interrelated and should all be included in the model. 

At the end of this task... I thought that I should've come up with something simpler for the homework, for example some phenomenon that has already been modelled but not exactly put into ODD protocol words. I thought of working with **fission-fusion** dynamics with the spider monkeys, and also including Pitheciines... I think uakaris are really cool and it would be nice to try and see the differences in fission-fusion dynamics between spider, uakaris, bearded sakis... and why not, chimpanzees. I might work on this for the final project instead... if the **pair-bonding stability** project is definitely not viable. 

___________________________________________________________________
###Feb 10, 2014 - Monkey apocalypse reloaded - zombies moving across barriers are driving me insane!!!

I've been working over the weekend trying to modify the zombie apocalypse model. The hardest/most challenging part has definitely been trying to get the zombies bounce off the walls properly. What I realized was that I could make the zombies/humans bounce off a "wall" (i.e. make them change their heading), but agents can bounce outside/across a barrier if the human-speed or zombie-speed is more than the distance between the agent and a barrier (after changing its heading). While changing the heading of the agents when they encountered a barrier, I realized that the order of operations is really important. At the beginning I tried to include the new code (changing heading when encounter barrier) at the end of the go operations for each of the human and zombies movements (avoid-zombies and chase-humans respectively), but then realized that I had to include it before the agents actually moved. I decided that the best position to insert this chunk of code was after the zombie/human evaluates whether there is a zombie/human ahead, then it modifies its heading according to the presence/absence of zombie/human ahead, and after that I made them evaluate whether there was a wall ahead of them. This is easy to do if the agents were just moving one step (fd 1) every time step, but when their speed is variable and more than just one patch per time step, it makes it more complicated (as explained above).

I've been looking a lot at blogs and examples of different models, but the ones I've seen have the agents moving only one step at a time, so it doesn't really apply for this model. 

I tried making the barriers as a new breed [walls wall] but this was hard because it made x amount of walls depending on how much time I clicked on the mouse, and it ended up making like 40 walls for every click. Then I realized that part of the homework was to change the patches to be walls, so I decided to stick to the idea of walls/barriers being set up by a change in patch color. To try and make larger barriers I tried to increase the size of the mouse when painting barriers, but realized that pen-size can only be applied to turtles, not to patches. 

At this point I have most of the homework ready... except the proper bouncing off the walls from the zombies and humans (big/important part of the homework!!!), and getting the model to export data every 100 ticks instead of every tick. I think I still don't understand how reporters work because every time I try using a reporter I keep getting errors...

I found what it seems to be a good option in the BehaviorSpace section of the NetLogo dictionary. I found that to make an output every n number of ticks, I could use 'repeat 100 [go]'. However, I tried this and instead of running he code every tick, it ran the code 10 times before the first tick was completed... which is definitely not what I want.


________________________________________________
###Feb 11, 2014 - Importing/Exporting patches. 

I couldn't find a proper primitive that allowed me to import/export only the patches from the world, so what I did was to export the entire world, without the agents. To do this I created two new buttons: one to export patch and another to import patch. In the setup procedures instead of having clear-all, I included only clear-turtles. That way, I could hit the setup button again without losing the walls created or imported. 

To export the data of number of zombies and number of humans every 100 I basically modified the modified flocking example we worked through last class period. Again, it works fine creating output every 1 tick, but have not figured out how to make the output every 100 ticks. 

I've been trying to create a list that contains numbers 100, 200, 300... up to 10000, and make an if statement, where if number of ticks is within that list, then write-to-file. But... I haven't figured out how to make a list just like in R, where you tell it to make a list from 0 to 1000, every 100. Something like that... 

This is really frustrating... it feels like it should be way easier! I've though of making a string from 1 to 100 and then multiplying it by 100, which would give me a list from 100 to 10000, with numbers every 100... but I think this is overly complicated and it should be...

Tried 'every'... almost worked, but it uses seconds, not ticks. :-( 
This is really frustrating... I tried 'every', 'foreach', 'n-value', making lists that multiply with other lists... and nothing works... worst case scenario, do it manually! 

______________________________________________________________
###Feb 11, 2014 - Entry #2. I get by with a little bit of help from my friends... 

So after trying many different ways on how to output data every 100 ticks, in an act of frustration I sat back on my couch and opened one of my favorite iTunes playlists: "The Beatles". After a couple of songs, I heard the melodic voice of Ringo Starr** talking to me. It was definitely a sign from... The Beatles. I was stubborn to ask my fellow classmates for help, but after all the frustration and Ringo's message I decided to try and find a little bit of help from my friends. 

**(I wanted to write "the melodic voice of Paul McCartney" but decided google who sang this song, and to my surprise it was Ringo Starr!... Oh! The things you learn doing agent-based modeling...).

My friends gave me the hint of using the mathematical primitive "remainder". In that way, if I divided the number of ticks by 100, I would only get results with no remainders every 100 ticks. I used this formula in my 'if' statement to write-to-file, and it worked!!! I knew it was not supposed to be so hard! I was doing it the opposite way... I was thinking on multiplying numbers that gave me a list of numbers that were 100, 200, 300 ... 10000, as opposed to thinking on division! 

Going back and forth on emails with my classmates, we helped each other on things we were stuck on or having problems with the code. They also helped me realize that to make my zombies and humans bounce properly off the walls without moving farther than the wall (if human-speed or zombie-speed exceeded the distance between the agent and the wall ahead). One way of doing this is using the repeat [ ] command, such that agents move one step forward looking for walls until they reach their speed. If they encounter a wall in that process, they change their heading and then continue moving the speed they are assigned. 

When I finally had all the requirements for the homework, I started testing every single bit to check that everything together worked properly. Doing this I realized that the first thing I had to do before running the model was to choose the file where I was going to save the output data. Otherwise, when it got to the 100th tick it popped a message saying that the output file had not been specified. 

**in-cone vs. in-radius**

I modified to code for humans and zombies behavior so that instead of using the 'in-radius' reporter I used 'in-cone' and assigned a maximum radius of 10, so that these two agents couldn't see across the entire world... which I thought it was kind of unrealistic (not that the whole zombie/humans living in a pacman-looking city is very realistic). To keep things realistic, I still kept the healers with the 'in-radius' reporter given that they have magical powers and therefore their vision shouldn't be constrained. 

**randomness in the model ---> overcrowding**

I also found out that no matter the initial values of the sliders, randomness is going to be very influential on the output. This is because the initial position of the agents in the world is set up to be random. Therefore, I can have two humans inside a building (surrounded by walls) so they wil start reproducing inside the building until it gets really crowded. For example, on the image below you would think that there are a lot more zombies (orange) than humans (blue/green), but if you take a look at the numbers in the monitors, the population for each agents is very similar to each other (1510 and 1233 respectively). This is because all humans are clumped in one building, while zombies are more spread out around the world. Good for humans who found refuge!... but boring for the model... 

<img src="crowded_humans_zombies.jpg" alt="Drawing"style="width:700px"/>

I could  include a code for population density, where if it gets too dense inside a building or specific area, people start dying faster. 

**humans also have to die**

After seeing that humans were crowding so much I decided to include a section in my code to make humans die after a certain number of ticks, to make the model run less human-skewed. I added energy levels to the humans so that their energy would decrease by one every time they moved (i.e. every tick). Include this I had to mention on the info tab (things to notice) that time for a human to hatch has to be smaller than time for human to die, otherwise all humans die before they get a chance to reproduce. 

**model running too slow after a couple hundred ticks**

Although my model seems to be running well... I still couldn't figure out how to set up the parameters so that it runs properly up to 10000 ticks. It runds good enough up to ~400 ticks, but then it becomes really really slow, even after I modified the initial populations to be very low. If I started with high population numbers, after a few ticks the total number of humans and/or zombies was insanely large making the model run too slow. 

**info tab: no spelling check**

While entering text in the info tab, I realized that I have to be more careful because it doesn't seem to have a spelling check. 

______________________________________________________
###Feb 12, 2014 - Stop thinking in R code

One thing I forgot to mention in my previous journal entries and I just remembered, was that while I was trying to code, I kept thinking on R coding... I tried the repeat function as a way to do something similar as a loop in R, but they work differently. More specifically I wanted to do something more like a for-loop in R, but didn't know how to in Netlogo. In general, many of my problems were because NetLogo has a lot of built-in primitives which I'm still not completely familiar with, so I do not know what I have to "make up" myself in the code, or what is already available... 

_________________________________________________________
###Feb 12, 2014 - Thoughts on the readings for today 

Dummont and Hill (2004) mention the need to get prior field data in order to apply the model thoroughly. This is really important given that, as mentioned in the reading, there is a number of models that are based on assumptions that violate some biological principles of the organisms you want to model. This is why prior information of ecological and behavioral aspects of the species are needed before implementing models. Also, I feel like many of the ecological models make a big deal of the impact the model might have on conservation strategies... however, for this to be true, prior data had to be precise, and models should be tested in the field to determine whether real organisms are really behaving like the model predicts.  

One of the questions that come up to my mind is how to apply a generalized model to multiple species. I know that in general, animals follow basic biological principles, but when you want to see the effect of a specific model on a species, you might have to add or remove some of the variables given that they might not apply or be appropriate for your species. In that case, how many added/removed variables would be allowed before the model loses its main structure... and instead becomes a totally new model? For example, in the reading they are talking about herbivorous species, but sheep, cows and other herbivores might differ so much in certain aspects that they might not be comparable??? I don't know... what would be the degree of similarity/difference required to apply a specific model to different species? For example, when talking about the moose, they include many physical, physiological and cognitive attributes that were not included in models for sheep and cows. Therefore... are these comparable in terms of foraging efficiency if models differ that much?

When talking about spatial memory as a two-part code they talk about reference memory (mapping-like representation of feeding sites) and working memory (remember which feeding sites have been recently visited). How does this differ of spatial and temporal memory, where reference memory would be equivalent to spatial memory and working memory would be equivalent to temporal (what time is it appropriate to visit? Not only time of year, but time considering previous visitations... ). 

When you have so many parameters like in the sheep model (40 parameters, or also in the Optimal foraging model), can you do a statistical test on which parameter(s) are the most influential in their foraging behaviors? I'm assuming the model would still give similar results if one parameter is removed... I'm assuming more parameters simply gives more accuracy to the model... but again, would be harder to test/verify/evaluate in the field?

Is Tony's GENESYS a hybrid model of ABMs including genetic distance data? How does it exactly differ from ABMs in NetLogo... (read Lina's paper...).

When do you use the ODD headings in a paper? In the Optimal foraging paper (Nonaka and Holme 2007) they seemed to be following a purpose, scale and variable states with assumptions, design and details.. just like the way it is presented in the methods is not exactly the same as it is presented in the ODD protocol. When to use "own" headings and when to include the ODD protocol as is? Should the ODD protocol for a model be specified only as an appendix? 

In Shipley and Spalinger (1995) MVT underestimates patch-staying times because they used straight-line distances instead of path lengths... are euclidean distances useful at all in spatial models? Shouldn't you always consider path lengths? How to correct for this underestimation? Several species have reported values of home range which can give an estimate of distances travelled, but not many have reported values for daily path lengths. 

Patch staying times... probably strongly influenced by predation pressure, open vs. closed canopy?

EMERGENCE CHAPTER

Unpredictable emergent model outcomes vs. imposed outcomes forced to occur or predicted by the model's assumptions.  

Online I found a website describing BehaviorSpace. I found this when I was trying to get the model to export data every 100 ticks. I found the repeat [go] function, but don't really understand why this is related to BehaviorSpace, and not in the regular NetLogo dictionary? In general why aren't the BehaviorSpace terms included in the NetLogo dictionary? However... to be honest, I didn't open the Experiment tab, and maybe that would've helped. Looking at this dialog box, I could've done the "output every 100 ticks" and the "stop at 10,000 ticks" on this dialog box (Time limit or Stop condition), if I only wanted the data to be exported from 100 to 10,000 every 100 ticks.  


________________________________________________________________
###Feb 17 and 18, 2014 - Working with Behavior Space

#####BEHAVIOR SPACE - FLOCKING WITH PREDATORS

I left repetitions = 1 but when I finished the experiment in the Behavior space dialog box it said that my sensitivity analysis would be run for 891219 runs. Why this number? Googled and didn't get any answer. 

Before running the experiment, I have to indicate how many simultaneous runs in parallel I want... which is the best criteria to choose this number? It gave me 8 as default, but don't really understand what this means. 

Confused at the beginning. Should I run a single sensitivity experiment for each variable I will change (i.e. one experiment for changing human speed, one experiment for changing monsters speed, etc.), or one single experiment changing all these variables. In the book it says that the sensitivity analysis is supposed to show you how your output changes when you keep all the global variables constant and only let one variable to vary. I started doing a single experiment where speed and vision angle varied in humans and monsters. 

Not sure about the repetitions section...

Now I get it. I had a huge number of runs before because it is all the possible permutations given the "vary variables...". So what I had initially was to change the vision angle increasing it every 10 degrees, and the speed increasing every 0.1. Therefore, the number of possible combinations was 891219 runs. What I did was to make the increments lower, where I increased the vision degree angles every 30 degrees and increasing the speed every 0.5. This decreased the number of runs to 5915 runs, which sounds more feasible. 

At the beggining, I had it to start on speed 0 increasing every 0.5. However, if I start with speed 0 nothing is going to happen... agents are not going to move therefore the run is going to take forever. That is why I started with speed at 0.5. This decreased the number of runs to 4056 runs. 

When angle of vision for humans is 0, they do not create any flocks. Human vision angle is 240 degrees they form flocks where they all just go in a straight line. When monsters vision is 0, it seems that they en up moving together following humans. But this only happens when there are only a few humans left, not when there are many scattered. Therefore, the 3 mosnters are going to move clumped together following the only humans alive. 

For the stop code, I tried entering 'humans = 0' and it wasn't working I used 'not any? humans' instead and it seemed to work.

It takes A LOT of time to do all the runs. It took almost 10 minutes to run 89 out of 4056 runs. 

I was really stupid and hit the abort button thinking I could pause it to check the edit settings of the experiment. It would be nice if there was a 'pause' button. 

40 minutes to complete 473 runs!!! Will abort and decrease the increment number. Changed it to have a minimum speed of 1 patch/tick, and to increase the vision angle every 45 instead of every 30. This gave me a total of 1215 runs. Still a lot... but more reasonable. 

After 4:39 hours (!!!) I get an error message saying that 'Stopping condition failed to report a result: not any? humans'. I checked the dialog box and said that it was on step #135884 of run #1179/1215, so maybe it exceeded the amount of runs? This is the case run where both humans and monsters have full vision (360 angle) but humans more at a 2 patches/tick speed while mosnters move only 1 patch/tick. It would also be nice if there was a way to skip a specific run in the experiment if it is taking too long.

After almost 5 hours, I had to unwillingly click the abort button...  there was no way those monsters would get to the lonely human since the human was faster... 

However, when I went back to check the excel file, to mu surprise the 1215 runs had completed, with the exception of the run #1179.

Just playing with the output, in general tables are so much easier to read and sort than the spreadsheet output from the experiments. 

RESULTS

Quick view. If I sort out by number of ticks (to see under which conditions were humans more persistent) and the largest number is when human speed was max = 2 and monster speed was min = 1, when human vision angle was 270 and monster vision angle was 90. Sorting out didn't show any clear pattern of when humans were most persistent. 

So... I figured out this was really stupid! As usual I keep making the silliest mistakes! Instead of keeping one variable constant, I did one single experiment which included all possible permutations. That is why it was taking so long! I decided to keep all variables constant except one, every time. 

Changing only speed to increase every 0.5, I had a total of 36 runs which were complete after 5 minutes. So much better... 

Also, I just figured out that if I uncheck the update view box, the model runs so much faster!!!

Tried playing around with R but I'm quite rusted on R coding, so I thought it would be quicker to do it in Excel... not sure about that. Easier, but definitely more work and not such pretty graphs... 


#####FLOCKING MODEL MODIFIED

QUESTION 2

BASELINE EXPERIMENTS

First I did several runs and noticed that the mean standard deviation stabilizes around 500 ticks. Therefore, I set up my Behavior space to stop at 500 ticks. 

Having problems with the plot so turned "off" (placing ;; before in code) for that coding section for the plot. 

As I was running this experiments I could see a Behavior plot... why??? I couldn't realize how to make this show up or not, but it was nice to have it there. 

I was always getting a runtime error saying:

COUNT expected input to be an agentset but got the number 0 instead.  
error while turtle 358 running
called by procedure __EVALUATOR

After a while I realized that this happened because when the model started its run, there were no flockmates. Therefore, during the setup I had to add an extra line of code that said 'set flockmates no-turtles'.


#####MODIFYING NUMBER OF FLOCKMATES = 6

I simply had to change the code in the find-flockmates procedure. Instead of having it to be min-one-of [distance myself], I replaced it by min-n-of 6, which reports the 6 closest flockmates. 

Changed: 

	 find-nearest-neighbor ;; turtle procedure
  	set nearest-neighbor **min-one-of** flockmates [distance myself]
	end

to  

	to find-nearest-neighbor ;; turtle procedure
  	set nearest-neighbor **min-n-of 6** flockmates [distance myself]
	end


QUESTION 3

It was really easy to do this  (specifying the angle of vision to set heading and find flockmates) by changing the in-radius primitive and replacing it by the in-cone primitive.

QUESTION 4

This was tricky. At the beginning I tried to incorporate the code of sex-associations (same-sex, opposite-sex, or indifferent) in the go procedure, but it was clearly not working. I was getting error messages for the same-sex and opposite-sex associations when animals were trying to cohere and separate. Then I simply added the code in the find-flockmates procedure to change their heading when finding flockmates and this worked. 


This homework was challenging but fun. It was all a process of trial and error, but with a LOT of error. Once you have an idea of how things work... things are much easier. My biggest problem was definitely at the beginning when I thought that I had to include all the variables and permutations in one single experiment. Also, it is tricky sometimes to figure out how you want to visualize your data. There are different ways to graph your results, and I thought the best way to graph most of these results (at least for question one) was using a 3D graph, but couldn't find how to do this in excel or ggplot using R. When there are many variables that are changing, and interactions between variables in an experiment, you have to decide which is the best way to create the graphs for them to be most informative or easier to read. 
 
___________________________________________________________
###Feb 19, 2014 - Thoughts on Readings Week 6


#####Nathan et al. 2008

Four basic components of organismal movement:
1. The internal state (why move?)
2. The motion (how to move?)
3. Navigation capacities (when and where to move?) - ability to orient in space and time
4. External factors affecting movement. - Aspects of biotic and abiotic environment influencinf movement. 

Same movement can be attributed different classifications. E.g. foraging = moving-within-patches = station-keeping. It really depends on whether it is defined in terms of a goal, the landscape or temporal dynamics. 

Eulerian approach: quantifies population re-distribution
Lagrangian approach: quantifies movement of individuals. For larger organisms - relies on high spatiotemporal resolution over sufficiently large spatiotemporal scales. Telemetry! (limited in body size).  --> BUT ALSO DEPENDENT ON COST! THESE ARE EXPENSIVE TECHNOLOGIES.

Ecoinformatics. 
Movement databases: www.movebank.org

Tracking tech compared with genetic sequencing. 
Lifetime movements??? Really depends on life history variables and telemetry capacity. For large long life history animals it would be harder to have a device that lasts than long. 

Movement phases, sampling frequency. The deconstruction of a movement path into a sequence of movement phases depends on the temporal resolution of the data. 

Movement phases - made up of smaller units: CANONICAL ACTIVITY MODES

It feels like it would be overwhelming trying to create a model with so many different variables, that can change a lot through time. How precise is the model for a different time period? Looking at internal/external factors observed today, can we really know whether these variables were the same in the past? Can it really tell us about evolutionary history and ultimate causes of specific types of movement?

Characterization of movement... looks very bird-oriented (?)


#####Conradt et al. 2003

So, basically looking whether there is a consistent emerging pattern when modelling foray seach? Modelled in habitat patches, but how is a patch defined? From the title I assume they refer to a fragmented landscape, but a patch can simply be a specific patch in the forest with available resources, or a fruiting tree... differences between different types of patches are important, therefore it is important to define what they mean by patch. And what about movement in a non-fragmented forest? Does dispersal happen in the same way? How does it change? 

Does the dispersal strategy explained is restricted for movement in a straight line in an ellipsoidal pattern, or does it allow some degree of randomness in the movement? Also, is there a width parameter specified that allows some flexibility in movement? 

Energetic constraints in foray search - why carry around resourcces? Is it because it is a fragmented landscape? What about corridors? Don't they have resources in between that support individuals during their dispersal movement? Not all species require these types of energy reserves because they can get resources along their dispersal movement.


#####Fronhofer et al. 2013

Memory - lots of variation across species. The degree in which individuals can memorize is going to depend at some extent in the cognitive abilities of the species in general.

Wang and Grimm 2007

Daily time scale. From the papers we read for this week, this is the only one that makes a clead ODD protocol (obviously... because one of the authors is Grimm, creator of the ODD protocol). So when use and when not to use this protocol as part of the publication? For example, on Tony's paper with Lina, they don't really write an explicit ODD protocol like it is written down here... so I wonder when is it appropriate and when is it not? Also, I was expecting to find supplementary material that included the code for the Tamarins paper... why not include it? 

I thought this paper was nice because tested the model against actual data collected in the field. 

All these papers talk about individuals looking for resources, but what about when movement patterns are not dictated mainly by food but other things? For example, primates... males seeking females. Of course this will be determined by food availability and distribution for females, and in turn affect male movement patterns... but males might be seeking specific females in their reproductive status, and their movement patterns might be different from females that are not sexually receptive at a given time... 

________________________________________________________________
###Feb 24, 2014 - Working on new ODD => POLYGYNY THRESHOLD MODEL 

I've been reading about the polygyny threshold model, like Tony suggested. I do agree that my previous ODD protocol was kind of vague. Especially because I think it was very specific for saki monkeys, and very specific to the saki monkeys that I know, which are the ones from Tiputini. So I decided to follow Tony's advice and do something more general and related to mating systems, such as the polygyny threshold model (PTM). This model is very socioecological, which is really good to use on an AMB since I can model landscapes with habitats that vary in their distribution and abundance of resources, males trying to monopolize the better quality habitats and females choosing to mate with males that defend the most productive habitats (better quality in resources). I think the PTM is better to model on Netlogo since it is more precise and it doesn't have so many variables like I was thinking before for the saki monogamy model. 

Although PTM is mostly studied on birds it can also be applied to other species such as primates. The PTM makes reference to birds where females are choosing the males for mating, which is similar to what is observed in many primate species where females are considered the "choosy" ones. I will start modeling this model in the simplest way, following the basic statements of the PTM, and then the model can be tweaked to determine some parameters for specific primate species.  

__________________________________________________________________
###Feb 25, 2014 - Working on the PTM model

I started creating the setup environment for the PTM. The idea is to start the model with males established in specific territories that have a specific amount of resources. Then females start moving in the environment looking for males that are established in territories that meet their minimum nutritional requirements. I assigned dominance levels randomly to males, and what I wanted initially was to setup the males first and then they would create a territory depending on their dominance level: more dominant males would be able to establish in territories with more and higher quality resources. For this I would setup the resources first in the landscape, and then introduce the males to create their territories. However, I thought this was hard to model, and it could be conflicting when a male was displaced from its territory by a more dominant male. To keep it simple I decided to create the territories first, dividing them by a grid, and then placing dominant males randomly to those territories. I have not figured out whether it is better to have resources to be assigned as a patch with a different color, or to be assigned as an agent, and then territories would be an agentset with resources... dunno! 

Anyway... how I did it was to make resources to be patches of different colors and then territories are divided by a grid (that is also determined by patches of different colors). To make the resources I used the model we used on a model we used previously in class (the foraging model) and to create the grid I modified the code that was used in one of the models in the Netlogo library (the Traffic model). 

Ideally, what I want to create is different patches that have an ID and have a random number of initial resources. Then the most dominant males move to the better quality patches and then the females move randomly until they find a territory that has a male and that has the minimum resource requirements. I decided that females do not have to look for the better quality territories, but instead look for males, and if the male in that territory can monopolize enough resources, the female decides to stay regardless of the male's dominance. Dominance only determines where the males are going to be established according to the habitat quality. 

I also started working on the skeleton for the to go procedures, and I have some ideas of the workflow, but haven't set them up to work yet... However, making up the skeleton really helped me for writing the process overview and scheduling of the ODD protocol. Actually, what helped me the most and I think it is a really good idea, were the powerpoint slides with the flow chart of the go procedure for males and females.

_________________________________________________________
###Feb 25, 2014 - Disappointment with my grade from last week. 

I think the assignment for last week was hard and it took me a lot of time! So it was kind of disappointing to see my grade... I guess maybe I'm not reading the assignments correctly, or I'm really not understanding what Tony wants us to do... Maybe the assignments could be a bit more specific. Not leave questions for "pick some variables", but maybe specify which type of variables? This is because in the previous assignment there were too many things that could be done, so I picked to see change the variables that we used when we were working on the flocking model during class... 

__________________________________________________________
###Feb 26, 2014 - Reading: Parameterization and calibration

Parameters - constants in equations and algorithms
Parameterization - step of selecting values for a model's parameters. 
Calibration - find good values for a few especially important parameters by seeing what parameter values cause the model to reproduce patterns observed in the real system. 
- calibrating models against data
- calibrating models to fit a model to data

Why calibrate?
1. Calibrating a model: we want to force the model to match empirical observations as well as possible. Make the model more accurate/predictable. 
2. Calibrating a parameter: to estimate the value of parameters that we cannot evaluate directly.  (a.k.a. inverse modeling). 
3. to test a model's structural realism. How robust the model is. 

In ABMs, each submodel can be parameterized  and tested by itself. Calibration in ABMs is a "fine-tuning" of a small fraction of its parameters. 

Trick for credible parameterization: 
1. design your model so its parameters represent real quantities ir rates that could be measured empirically. Otherwise you just have to guesswork... which can be extenuating and time consuming!
2. show that your parameter values cause the submodel to produce reasonable results in all situations that possibly could occur. 

"guesstimating" parameter values:
1. define upper and lower bounds
2. fast or slow time scale? strong or moderate impact? often or rare? Define a reasonable range for parameter, from which you can select the middle, or try several values. 

CALIBRATION: execute a model many times, each time using different values and then analyze results to see which parameter values caused the model to best reproduce some patterns observed in the real system. 

Avoid overfitting. 

Categorical vs. best-fit calibration. Categorical: search for parameter values that produce model results within a category or range defined. Best fit: search for one set of parameter values that cause the model to best match some exact criteria (optimization).

Time-series calibration: for ABMs that simulate how a sustem changes over time. 

Simulation experiments: results of simulations will tell us what ranges of parameter values produce results that meet the calibration criteria. 

Analyze calibration experiment results: how closely does the calibrated model fit the criteria?
_________________________________________________________
###Feb 26, 2014 - Embedding images on the markdown

So I've been using the markdown for R studio, and Tony tells me he is having a hard time seeing the images. I tried using the MOU syntax, but I haven't upgraded my computer so the software I have is not compatible with the MOU syntax which requires MAC OS X 10.7+ (mine is OS 10.6.8 !!!). So what I did for now was to open the files in R studio and knit the information into an html file so that the images actually work. 

Here is some evidence that in R studio it works properly (and a photo for your collection of photos in the field):

<img src="evidence.jpg" alt="Drawing"style="width:700px"/>

_____________________________________________
###Feb 26, 2014 - Class notes

**For my model**

To keep track of all the kids that an agent has, make a list. 

For dominance interactions, dont make it a yes no but instead give probabilities of winning and taking over the territory. 

Instead make them jump from one territory to the other (as opposed to make them moving between territories). This simplifies the model. Make them jump just like in the SEGREGATION MODEL in the Netlogo library. 

Use generic food (dont make differences between leaves and fruits. Do it general = resources).

Check models that have different levels of patchiness. 

Check woodhoopoes model (canvas) for setting up territories. 

**From slides**

Visual testing
Scale-scolor, label and plabel


To import images: import-pcolors

Read-line. It reads and entire line of data, puts it in a string and looks up for spaces. It will print out words in a line. Reads and parses out based on, for example, white spaces. Reads all characters until end of line and then separates words. 
The other one does the same but does it until you hit enter. It separates by when you hit enter???


_____________________________________________
###Feb 28, 2014 - Checking out the Woodhoopoe Model 

Tony said it would useful for me to check the Woodhoopoe model. To be able to open two windows of NetLogo in my Mac computer, I followed Tony's advice of copying the folder where Netlogo is located. I copied it and gave it a different name and it worked. This model simulates woodhoopoes scouting for vacant territories after they decide to leave their group, which is basically what I want to do with the males in my model. Reading the info tab there are a lot of similarities with what I want to do. 

_"Birds undertake scouting forays. Subordinate adults decide whether to scout for a new territory with a vacant alpha position, using the scouting decision submodel described below. Birds that do scout choose randomly (with equal probability) between the two directions they can look (left or right along the row of territories). Scouting birds can explore up to five territories in their chosen direction. Of those five territories, the bird occupies the one that is closest to its starting territory and has no alpha of its sex. If no such territory exists, the bird stays at its starting territory. All birds that scout (including those that find and occupy a new territory) are then subjected to predation mortality, a stochastic event with the probability of survival 0.8."_

Especially regarding territories having alpha and subordinate individuals. In my case, there will only be a hierarchy among males, and females will all be the same rank. Also, in my model I will not include chances of predation. 

However, I have to include mortality in my model, otherwise there will be too many birds for the amount of territories. 

I guess my model functions using the same basic principle as the woodhoopoe model: the stay-or-leave question of when should an individual (in my case it would be any agent: an unsatisfied female or an unsatisfied male) leave a group. In the woodhoopoe the decision of staying or leaving in a group is based on the idea that a group provides safety for individuals. However, in my model this decision is based on the availability of resources for individuals. 

So... in the whoodhoopoe model, the size settings are 12x0. So there are 12 patches in a row... so each territory is a single patch?

I've spent a while to make a checkerboard pattern for the patches of my world... it seems to be more complicated than I thought. I am using the remainder function so that 
	
	to setup
	Shade the patches
  	ask patches
  	[
    ifelse ((remainder pxcor 2) = 0.0) and ((remainder pycor 2) != 0.0)
    [ set pcolor black]
    [ set pcolor white]
    ifelse ((remainder pxcor 2) != 0.0) and ((remainder pycor 2) = 0.0)
    [ set pcolor black]
    [ set pcolor white]
  	]
	end

but this seems to be more complicated... this does not give me a checkerboard pattern, but instead it just gives me a black/white pattern for ycor lines 0,2,4... but not for ycor lines 1,3,5...

This is because I am overriding the first ifelse with the second ifelse. 

I'll try tomorrow...

I kept working for a bit... and finally got it to work!!! Good night!
______________________________________________
###March 1, 2014

Last night while I watching a movie and eating pop corn, I thought it would be pretty cool to model how corn kernels pop. Pop corn kernels are supposed to pop into different shapes depending on the structure of the kernel. Just like the fireworks model in the NetLogo library, it would be interesting to have a pop corn model... 

<img src="popcorn.jpg" alt="Drawing"style="width:300px"/>

_________________________________________________
###March 4, 2014

Today I've been trying to setup the agents. Incorporating females and trees is easy... I'm simply setting them randomly in the world. The tough part has been incorporating the males. Basically what I want them to do is to be ordered in number of dominance level, and then have the male with highert dominance move-to the patch/territory with more trees (so basically I had to setup the trees first before setting up the males). I've been able to have them go to the patch with most resources, but I'm having a hard time having each male go to a specific patch. I've been trying to create while loops, but have not succeded. Also tried using sort and foreach, but it didn't work. After trying for a long

I asked Tony for help and it works now. 
 
One of the problems was that the way I was assigning dominance, two males could have the same dominance. I was using the 'random' function, as opposed to the random-float. Tony's advice was to assign a dominance value to each male using random-float, and the sort them out and assign that order to a new variable that is called rank. Therefore, males with lower dominance values will have the higher rank (this is counterintuitive but it helps modeling in such way that you can rank them), where males with rank = 1 are the ones who are going to the territories with more trees. We did this by first assigning dominance using the random-float, and then using foreach and sort-on to assign rank. Then we asked the males in the rank order to find-pathches if they were not occupied by a higher ranking male. 


	create-males initial-males [
	set shape "bird side"
	set size 0.2
	set color blue
	**set dominance random-float 1**
	set male-energy 50
	]
		let i 1
	**foreach sort-on [dominance] males** 
	[ask ? [set rank i set i i + 1]] 
	foreach sort-on [rank] males [
	ask ? [find-patch ask patch-here [set occupied? true]]
	]


To find-patch what they did was to move to the unoccupied patch with maximum number of trees. 

	to find-patch
	move-to max-one-of patches with [occupied? = false] [number-trees]
	ask patch-here [set occupied? true]
	end


Now the setup of the world is working just like I wanted!!! :-) Thanks Tony!


_________________________________________________
###March 5, 2014 - DomWorld

This is going to help me a lot with my model!

I could include in RANK REVERSALS, where lower ranking males that defeat higher-ranking males take over their rank status, and vice versa. That way, lower-ranking males can escalate. 

Be careful with the probability of success of lower-ranking males. Do not exaggerate. 

I could also include something similar to the fleeing model, where males that are defeated have to move in-radius x from that territory (therefore, they cannot simply move the next available patch, if the patch is adjacent to the winner... ). Just an idea... 

____________________________
###March 5, 2014 - MarkdownPad

I downloaded the MarkdownPad to make the .md file because when I copy-pasted the code it looked funky. I'm still trying to figure out how to enter code appropriately... 

Got it! I just have to enter tab ... 


___________________________
###March 14, 2014 - Hackathon

Working through this hackathon now I feel (a bit) more confident now while coding. I know I’m not the best at coding, but at least it now takes me less time to achieve something I have in mind. For example, I feel a bit more confident with foreach primitive and differences between set and let. Something I’m still having a bit of problems is with reports, but while doing the plot I feel like it makes more sense now (although I ended up not using to-report in the plots). 

One of the most important things I realized during this hackathon was the importance of the order of the procedure. IT'S ALL ABOUT THE PROCEDURE!!! It really matters where you put things in the code. For example, I  had a lot of problems trying to assign whether males were happy or unhappy, and that is because I was inserting this chunk of the code right after setting up the males in the world. However, their level of happiness also depends on how many females are there in the patches, and I hadn’t set up the females at this point. This made either all males become happy or all males be unhappy (Happy? = true/false). I realized that I had to insert this part of code AFTER I had created the females. When I did this it worked just fine. 

Another problem I had was trying to make males and females go only to trees that still had energy/resources. First I tried to tweak the “hidden?” attribute for trees, so that trees became hidden (hidden? = true) when their energy dropped to 0. However, this was not working for me so I tried changing the color of trees and it worked just fine. What I did was to make trees turn unto the patch color (pcolor) when their energy levels dropped to 0. Then they would turn back to red when the regeneration time had passed and resources (tree-energy) would be available again for males’ and females’ consumption. I also found this really nice because the tree icon, when turned into the pcolor, the small tree trunk remained visible, so it was easy to track when a tree had run out of resources (when all or most trees had run of resources it looked like a deforested tree). 

I feel that many of my go procedure is very repetitive. However, I don’t know if I can make it more general because attributes for males and females are specific (although similar e.g. female-energy and male-energy). I thought of making just one agentset and dividing them into males and females (sex attribute)… it is something I can try in the future to simplify the model. 

Something I’m still having problems with is some of the syntax. For example, it is still a trial-and-error thing for me to decide when to use brackets and when these are not necessary. For example, I still don’t understand why this works

 		move-to min-one-of trees with [color = red] [distance myself] 

…but this doesn't: 

		move-to min-one-of trees [distance myself] with [color = red] 

when I’m trying to make the turtles move to the closest tree that is visible. 

_________________________________
####March 16, 2014

Yesterday I tried to setup my github account on my computer, but apparently github only works on Mac OS X 10.7 or above (and my computer was 10.6.8). I was able to create the repository online, but couldn’t add the file. What I did was to finally install the new software in my computer (which is good because now I can actually use MOU syntax, which also requires OS X 10.7 or above). 

When I got to upgrade my computer, I downloaded github but still didn’t know how to add a file. Later (Monday), Tony helped me to create the repository. This was also really simple. All I have to do is save the file in the folder that is the repository. Tony also mentioned that I can make changes online and then clone it into my computer. 

URL: [https://github.com/labondano/Abondano-ABM/tree/master/PTM](https://github.com/labondano/Abondano-ABM/tree/master/PTM)

__________________________________________
####March 17, 2014 - Plotting

Today I was trying to make some output plots, and I was having problems. I would set up pens and everything, but nothing would show up. Tony helped me and it was something really silly! I wasn’t calling the plots in the go procedure, so of course the code for the plots wasn’t showing up. All I had to do was to include the plots on the go procedure, right after the tick line. 

e.g.

	to go
		move
		bla
		bla
		bla
		tick
		do-plot1
		do-plot2	
		do-plot3
	end

When doing the plots, I also tried to use reporters (to-report) but then I realized that for I was doing it was not necessary and I could just write it down in the plot procedure. However, if the plots are complicated to-report procedures will be useful. 

___________________________________________
####March 18, 2014 - Output graphs and ideas for the model

For today's assignment, we had to have some sort of output. First I thought that it would be better to do some experiments on BehaviorSpace, but since I'm interested in looking at fluctuations of polygynous vs. monogamous groups as resources increase or decrease, I thought it would be better to use the graphs that I created on the model. 

While doing this, I realized that if I right click on the plots, I can export them into a .csv file. This can be useful if I just want to export the plot data and perhaps do some quick stats, as an alternative to behavior space. 

Some of the output graphs I obtained were hard to analyze. I have a lot of fluctuations from one tick to another, so its not a smooth line that is easy to read. I don't know whether this is some error in my model, or this is just how it is. I still have to include several things to the model, such as females reproducing and having infants moving with them until they reach certain age. I was thinking of also giving age to individuals, so when they reach certain age they die, and that way I won't overcrowd the world. 

Other things I thought it would be nice was to have males and females moving towards the patches with the total amount of resources available (tree-energy)), instead of the total amount of trees (which is not a true representation of the amount of energy that the patch is providing). I could also try to have the minimum amount of resources to be the actual number of resources (tree-energy) as opposed to the amount of red trees required). 





