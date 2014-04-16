Laura Abondano
Programming assignment
NetLogo and R and MySQL, oh my!
========================================================

Install and load required packages to connect R and Netlogo

```r
library(rJava)
library(JavaGD)
library(RNetLogo)
```


To load modified Flocking model from Netlogo:

```r
nl.path <- "/Applications/NetLogo 5.0.5"
NLStart(nl.path, gui = FALSE)
nl.model <- "/Users/Bondi/Dropbox/UT-Austin/4th Semester/Agent Based Modelling/Abondano-ABMGitHub/SQLFlocking/Flocking.nlogo"
# replace the path above with your own path the to Flocking.nlogo program
NLLoadModel(nl.model)
```



