globals [
  ;percent-monogamous
  ;group-sizes  ;; A list of group sizes by patch, for output
]
  
breed [trees tree]
breed [males male]
breed [females female]
breed [infants infant]

males-own [
  dominance
  rank
  ;status ;; resident or roaming
  male-energy
  male-happy?
  ;;parental-care???
  probability-win
  offspring-sired
  ;win
  ]
females-own [
  ;;quality??
  female-happy?
  female-energy
  ;fertility-threshold ---> its already on the interface so its setup as a global. therefore, no need to have it here?
  female-min-resource-threshold
  female-ID]
infants-own [
  infant-ID
  mother-ID ; to create links
  father-ID ; to create links
  ;sex ---> set later when they become adults 
  ;infant-energy ;--> still don't know whether they should forage or not. if not, it makes no sense giving them energy.
  ;death-threshold
  infant-age
  age-dispersal]

trees-own [
  tree-energy
  time-till-regrow ]

patches-own [
  number-trees ;;  number of trees in patch
  patch-energy
  number-males
  number-females
  sex-ratio
  occupied? ]
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;; SETUP PROCEDURES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to setup
  clear-all
  reset-ticks
 
;;Set parameters and globals
  ;set group-sizes [] ; An empty list
  
;; World dimensions
  resize-world 0 (x-num-territories - 1) 0 (y-num-territories - 1)
  ;set world-width 5
  ;set world-height 5
  
;; Shade the patches
  ask patches [set pcolor green - 3]
  ask patches with [remainder pycor 2 = 0] 
  [
    ifelse (remainder pxcor 2) = 0
    [set pcolor green - 3]
    [set pcolor green - 1]
  ]
  ask patches with [remainder pxcor 2 = 0] 
  [
    ifelse (remainder pycor 2) = 0
    [set pcolor green - 3]
    [set pcolor green - 1]
  ]
  
;; Create trees 
  create-trees initial-trees
    [
      set color red
      set shape "tree"
      set size 0.2
      set tree-energy 10
      setxy random-xcor random-ycor
      set time-till-regrow regeneration-time
    ]
    
  ask patches [
    set number-trees count trees-here 
    set occupied? false]
    

  if (initial-males > (x-num-territories * y-num-territories))
  [
    user-message (word "There are too many males for the amount of "
                       "territories.  Either increase the amount of territories "
                       "by increasing the X-NUM-TERRITORIES or "
                       "Y-NUM-TERRITORIES sliders, or decrease the "
                       "number of males by lowering the INITIAL-MALES slider.\n"
                       "The setup has stopped.")
    stop
  ]


;; Create males
  create-males initial-males [
   set shape "bird side"
   set color blue
   ;set subordinate-value random-float 1
   set male-energy 100
   set dominance random-float 1
   set offspring-sired [] ;; an empty list to insert the IDs on infants sired
  ]

  let i initial-males
  foreach sort-on [dominance] males [
    ;ask ? [set rank i set i i + 1]
    ask ? [set rank i set i i - 1]
  ] 
  
  ;; position males with highest dominance values to patches with highest number of resources

  foreach sort-on [rank] males [
    ask ? [
      male-find-patch 
      ask patch-here [set occupied? true]
      ]
  ]
  
 ask males [  ;; size of males according to their dominance values. 
   ifelse dominance < 0.15
   [set size 0.15] ;; if they are smaller than 0.15 its very hard to see. So males with dominance values < 0.15 will be of size 0.15
   [set size dominance]  ;;; otherwise, if their dominance is > 0.15, their size will be the value of their dominance. 
 ]

; Create females
 create-females initial-females
    [ set shape "bird side"
      set size 0.3
      set color orange
      set female-energy 100
      setxy random-xcor random-ycor ;; females are not constrained to territories initially. They are wondering around until they get to establish in a male's territory.
      ifelse ((count trees-here / (count females-here + count males-here)) >= female-min-resources) and any? males-here
        [set female-happy? true]
        [set female-happy? false]
    ]
  
;; Assign males to be happy or unhappy (according to the their minimum resources threshold)
  foreach sort-on [rank] males [ ;;; this has to be after setting up the females!!! all about the procedure!!! DUH!
    ask ? [
      ifelse (count trees-here / (count females-here + count males-here)) >= male-min-resources
      [set male-happy? true]
      [set male-happy? false]
    ]
  ]
  
    ask patches [
      set number-males count males-here
      set number-females count females-here
      ifelse number-males != 0 and number-females != 0
      [set sex-ratio number-females / number-males]
      [set sex-ratio 0]  
      ]
  
end

  
to male-find-patch
  move-to max-one-of patches with [occupied? = false] [number-trees]
  ask patch-here [set occupied? true]
end




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;; GO PROCEDURES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to go
  ask males [set color blue] ;; so males that lost a dominance interaction in the last run turn back to blue
  check-variables
  move
  trees-fade
  regrow-trees
  ;females-die
  ;males-die
  females-reproduce
  infants-disperse
  ;infants-grow
  ;infants-move
  tick
  do-plot1
  do-plot2
  do-plot3
end

to check-variables
  check-patches
  check-trees
  check-occupied-patches
  check-female-happiness
  check-male-happiness
end

to move
  happy-females-forage
  happy-males-forage
  unhappy-females-seek ;; females seek for a territory where there is a male 
  unhappy-males-seek
end
  
;;;;;;;; CHECK VARIABLES ;;;;;;;;

to check-patches
   ask patches [
      set number-males count males-here
      set number-females count females-here
      set patch-energy count trees-here with [color = red]
      ifelse number-males != 0
      [set sex-ratio number-females / number-males]
      [set sex-ratio 0]  
      ]
end

to check-trees
  if not any? trees with [color = red]
  [user-message (word "No trees left. ")
  stop]
end

to check-occupied-patches
  ask patches [
  ifelse any? males-here
  [set occupied? true]
  [set occupied? false]
  ]
end

to check-female-happiness
  ask females [
    ifelse any? males-here and ((patch-energy / (count females-here + count males-here)) >= female-min-resources) 
  ;ifelse any? males-here and ((count trees-here / (count females-here + count males-here)) >= female-min-resources) 
        [set female-happy? true]
        [set female-happy? false]
  ]
end

to check-male-happiness
  ask males [
    ifelse ((patch-energy / (count females-here + count males-here)) >= male-min-resources) and (not any? other males-here)
      [set male-happy? true]
      [set male-happy? false]
  ]
end

to check-territory-quality
end


;;;;;;;;; FEMALES MOVE ;;;;;;;;; 

to happy-females-forage
  ask females with [female-happy? = true] [
  if any? trees-here with [color = red] [
  move-to min-one-of trees with [color = red] [distance myself] 
  ask min-one-of trees [distance myself] [
  set tree-energy tree-energy - 1 ]
  set female-energy female-energy + 1]
  ;[female-find-new-patch
   ;set female-energy female-energy - 1]
   ;[set female-happy? false
    ; unhappy-females-seek]
  ]
end



to unhappy-females-seek
  ask females with [female-happy? = false] [
    ;while [female-happy? = false] [
      female-find-new-patch
      check-female-happiness
      set female-energy female-energy - 1
    ]
end

to female-find-new-patch
  ifelse any? patches with [occupied? = true and ((patch-energy / (count females-here + 1 + count males-here)) >= female-min-resources)]
  [move-to max-one-of patches with [occupied? = true and ((patch-energy / (count females-here + 1 + count males-here)) >= female-min-resources)][patch-energy]]
  [die] ;; females disperse to find new territories. when they disperse, they die in the model. 
  ;move-to max-one-of patches with [occupied? = true][patch-energy] ;; NEED TO ADD THAT FEMALES GO ONLY IF THE TERRITORY QUALITY IS ENOUGH WHEN SHE COMES IN
  ;move-to max-one-of patches with [occupied? = true and number-trees > female-min-resources] [number-trees]
end


to female-find-new-patch2 ;; really bad coding,  non-efficient way of looping - looks up to radius 4 neighborhoods
  ifelse any? patches in-radius female-vision-radius with [occupied? = true and number-trees > female-min-resources] 
  [move-to max-one-of patches in-radius female-vision-radius with [occupied? = true] [number-trees]]
  [let i female-vision-radius + 1
    ifelse any? patches in-radius i with [occupied? = true and number-trees > female-min-resources]
    [move-to max-one-of patches in-radius i with [occupied? = true] [number-trees]]  
    [let j i + 1
    ifelse any? patches in-radius j with [occupied? = true and number-trees > female-min-resources]
    [move-to max-one-of patches in-radius j with [occupied? = true] [number-trees]]
    [let k j + 1
    ifelse any? patches in-radius k with [occupied? = true and number-trees > female-min-resources]
    [move-to max-one-of patches in-radius k with [occupied? = true] [number-trees]]
    [die]
    ]
  ]
  ]
end


to female-find-new-patch3
  let female-vision [1 2 3 4 5]
  let i 0
  ;let j 0
  while [i <= last female-vision] [ 
  ;set i item i female-vision
  set i 1
  show i
  ;set j item i female-vision 
  ifelse any? patches in-radius i with [occupied? = true and patch-energy > female-min-resources] [  
  move-to max-one-of patches in-radius i with [occupied? = true] [number-trees]
  ] [
  set i i + 1]
  ]
  
  ;check-female-happiness
  ;if female-happy? = false [female-find-new-patch]
  ;set female-energy female-energy - 1 --> removed this from here because I think it was making females lose more energy on one single tick
  ;if not any? males-here
  ;[female-find-new-patch]
  ;move-to one-of patches with [occupied? = true]
end


;;;;;;;;; MALES MOVE ;;;;;;;;;;

to happy-males-forage
  ask males with [male-happy? = true] [
  ifelse any? trees-here with [color = red] [  
  move-to min-one-of trees-here with [color = red] [distance myself] 
  ask min-one-of trees [distance myself] [
  set tree-energy tree-energy - 1 ]
  set male-energy male-energy + 1 ]
  [male-find-new-patch] 
  ]
end

to unhappy-males-seek
  ask males with [male-happy? = false] [
  male-find-new-patch
  ]
end

to male-find-new-patch
  ;let patch-energy count trees-here with [color = red]
  ;; move-to max-one-of patches with [occupied? = false] [patch-energy] ---> this is for cases when there are no interactions between males 
  ;; (i.e. males are not having dominance interactions among them). 
  move-to one-of patches with [patch-energy >= male-min-resources] ;; unhappy male moves to a patch that has resources that meet its minimum resource threshold
  set male-energy male-energy - 1
  ;; Dominance interaction between males
  if occupied? = true
  [dominance-interaction]
end

to dominance-interaction
  ;ask males-here with-max [dominance] [set probability-win random-float 0.8]
  ;ask males-here with-min [dominance] [set probability-win random-float 0.2]
  ;;ask males-here with-min [probability-win] [male-find-new-patch set size 5 set color "yellow"]
  ;ask males-here with-min [probability-win] [set color yellow male-find-new-patch]
  if random-float 1 < prob-subordinate-win [ask males-here with-min [dominance] [set color yellow male-find-new-patch]] 
end

to females-reproduce
  ask females [
    let mom who 
    if female-energy >= energy-to-reproduce
    [ set female-energy female-energy - energy-to-reproduce
      hatch-infants 1 [
      ;set breed infants
      set infant-ID who
      set color magenta
      set shape "bird side"
      set size 0.18
      set infant-age 0
      set mother-ID mom
      ;set father-ID [who] of males-here with [color = blue] --> this is if I want kids to have the number of father-ID. Not really necessary. 
      ;set mother-ID who of females-here
      ;set infant-energy 20
      create-links-with males-here with [color = blue]
      ;ask female mom [create-link-to infant infant-ID [tie]]
      create-link-with female mom [tie]
      let infant-sired infant-ID
      ask males-here with [color = blue] [set offspring-sired lput infant-sired offspring-sired]
      ]
    ]
  ]
end

;;;;;; INFANTS BEHAVIOR ;;;;;;;;
      
to infants-move
  ;ask infants [
   ; follow 
  ;; move on same cell as mother.
  ;; every tick they increase their age by 1
  ;; lose energy every tick
  ;; if infant-energy < death-threshold [die]
  ;; when they reach an age of dispersal, they become adults [breed males] or [breed females]
  ;; infants [disperse]
  ;; if infant dies [mother leaves territory and seeks new territory females-seek]
end

to infants-disperse
  ask infants [
    set infant-age infant-age + 1
    if infant-age >= age-of-dispersal 
    [die]
    ;[set hidden? true
     ;ask my-links [untie set hidden? true]]
  ]
end

to infants-grow ; and disperse
  ask infants [
    set infant-age infant-age + 1
    if infant-age >= age-of-dispersal
    [ ask my-links [untie set hidden? true]  
      let sex random 2 ;; it has to be 2, not 1, so it picks either 0 or 1. I had it before as random 1, but the outcome was always 0.
      ifelse sex = 1
      [set breed males
        set shape "bird side"
        set color green
        set male-energy 100
        set dominance random-float 1
        set size dominance]
      [set breed females
        set shape "bird side"
        set color red
        set female-energy 100]
    ]
  ]
end


;;;;;;;;;; TREE DYNAMICS ;;;;;;;;;;;

to trees-fade
  ask trees [
  if tree-energy <= 0
  ;[set hidden? true]
  [ set tree-energy 0
    set color pcolor
    set time-till-regrow time-till-regrow - 1]
  ]
end

to regrow-trees
  ask trees with [time-till-regrow = 0] [
    set color red
    set tree-energy 10
    set time-till-regrow regeneration-time
  ] 
end


;;;;;;;;;; AGENTS DIE ;;;;;;;;;;;

to females-die
  ask females [
    if female-energy <= 0
  [die]
  ]
end

to males-die
  ask males [
    if male-energy <= 0
  [die]
  ]
end

;to infants-die
 ; ask infants [
    ;if infant-energy <= 0
  ;[die]
  ;]
;end
  








to check-dominance ;; check wether male gets established or not in new territory
  ;; ifelse dominance of myself > dominance min-one-of male (male in territory) [true] [false]
  ;; new male stays and other male leaves 
  ;; set status of other male to roaming 
  ;; set status of new male to resident
end












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;; DO PLOTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to do-plot1
  set-current-plot "mono-vs-poly" ;; show how many monogamus territories vs. how many polygynous territories
  ;set-current-plot-pen "average-trees"
  ;let trees-available (count trees with [color = red] / (x-num-territories * y-num-territories))
  ;plotxy ticks trees-available
  set-current-plot-pen "%-mono-patches"
  let mono-patches (count patches with [number-females = 1] / count patches with [occupied? = true] )  * 100
  plotxy ticks mono-patches
  set-current-plot-pen "%-poly-patches"
  let poly-patches (count patches with [number-females > 1] / count patches with [occupied? = true] ) * 100
  plotxy ticks poly-patches
end


to do-plot2
  set-current-plot "resources for females" ;; show how many monogamus territories vs. how many polygynous territories
  set-current-plot-pen "trees-per-female"
  ifelse count females != 0 
  [let trees-per-female (count trees with [color = red] / count females)
     plotxy ticks trees-per-female
     ]
  [ user-message (word "All females died. "
                       "Try the following options: \n"
                       "1. Decrease number of females, \n"
                       "2. increase number of trees, \n"
                       "3. increase regeneration-time, or \n"
                       "4. reduce the female-min-resources. \n"
                       "The model has stopped.")
    stop
    ]
  set-current-plot-pen "mono-groups"
  let mono-patches count patches with [number-females = 1]
  plotxy ticks mono-patches
  set-current-plot-pen "poly-groups"
  let poly-patches count patches with [number-females > 1] 
  plotxy ticks poly-patches
end


to do-plot3
  set-current-plot "sex ratio of poly-groups" ;; show how many monogamus territories vs. how many polygynous territories
  set-current-plot-pen "trees-per-individual"
  let trees-per-individual (count trees with [color = red] / count turtles)
  plotxy ticks trees-per-individual
  set-current-plot-pen "mean-sex-ratio"
  ifelse count patches with [number-females > 1] != 0
  [let mean-sex-ratio mean [sex-ratio] of patches with [number-females > 1] 
  plotxy ticks mean-sex-ratio]
  [ plotxy ticks 0]
end
@#$#@#$#@
GRAPHICS-WINDOW
395
14
805
445
-1
-1
80.0
1
10
1
1
1
0
1
1
1
0
4
0
4
0
0
1
ticks
30.0

BUTTON
12
17
94
50
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
8
192
180
225
initial-trees
initial-trees
0
500
51
1
1
NIL
HORIZONTAL

SLIDER
8
110
180
143
x-num-territories
x-num-territories
0
10
5
1
1
NIL
HORIZONTAL

SLIDER
184
109
356
142
y-num-territories
y-num-territories
0
10
5
1
1
NIL
HORIZONTAL

SLIDER
185
191
357
224
regeneration-time
regeneration-time
0
100
20
1
1
NIL
HORIZONTAL

SLIDER
9
229
181
262
initial-males
initial-males
0
100
25
1
1
NIL
HORIZONTAL

SLIDER
9
266
181
299
initial-females
initial-females
0
100
76
1
1
NIL
HORIZONTAL

TEXTBOX
143
88
249
106
To setup world
11
0.0
1

TEXTBOX
143
169
247
187
To setup agents
11
0.0
1

BUTTON
105
17
168
50
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
176
17
239
50
step
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
188
267
360
300
female-min-resources
female-min-resources
0
5
0.5
0.5
1
NIL
HORIZONTAL

SLIDER
187
230
359
263
male-min-resources
male-min-resources
0
5
0.4
0.2
1
NIL
HORIZONTAL

SLIDER
9
326
182
359
energy-to-reproduce
energy-to-reproduce
100
300
104
1
1
NIL
HORIZONTAL

MONITOR
831
28
935
73
Trees available
count trees with [color = red]
17
1
11

PLOT
961
21
1219
175
mono-vs-poly
ticks
percent
0.0
200.0
0.0
100.0
true
true
"" ""
PENS
"%-poly-patches" 1.0 0 -14730904 true "" ""
"%-mono-patches" 1.0 0 -5298144 true "" ""

MONITOR
832
140
942
185
% monogamous
((count patches with [occupied? = true and number-females = 1]) / (count patches with [number-males != 0])) * 100
17
1
11

PLOT
961
185
1219
351
resources for females
ticks
count
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"mono-groups" 1.0 0 -5298144 true "" ""
"poly-groups" 1.0 0 -13345367 true "" ""
"trees-per-female" 1.0 0 -12087248 true "" ""

PLOT
960
357
1219
506
sex ratio of poly-groups
ticks
count
0.0
10.0
0.0
5.0
true
true
"" ""
PENS
"trees-per-individual" 1.0 0 -12087248 true "" ""
"mean-sex-ratio" 1.0 0 -12572331 true "" ""

MONITOR
831
78
938
123
NIL
count females
17
1
11

SLIDER
10
369
182
402
age-of-dispersal
age-of-dispersal
0
100
10
1
1
NIL
HORIZONTAL

MONITOR
832
191
933
236
% polygamous
((count patches with [number-females > 1]) / (count patches with [number-males != 0])) * 100
17
1
11

MONITOR
832
242
948
287
% roaming males
((count patches with [(occupied? = true) and (number-females = 0)]) / (count patches with [number-males != 0])) * 100
17
1
11

SLIDER
8
414
201
447
prob-subordinate-win
prob-subordinate-win
0
1
0.2
0.1
1
NIL
HORIZONTAL

SLIDER
9
460
193
493
female-vision-radius
female-vision-radius
0
5
1
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bird side
false
0
Polygon -7500403 true true 0 120 45 90 75 90 105 120 150 120 240 135 285 120 285 135 300 150 240 150 195 165 255 195 210 195 150 210 90 195 60 180 45 135
Circle -16777216 true false 38 98 14

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.0.5
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
