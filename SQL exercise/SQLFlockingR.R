library(rJava)
library(JavaGD)
library(RNetLogo)
nl.path <- "/Applications/NetLogo 5.0.5"
NLStart(nl.path, gui=FALSE)
nl.model <- "/Users/Bondi/Dropbox/UT-Austin/4th Semester/Agent Based Modelling/Abondano-ABMGitHub/SQLFlocking/Flocking.nlogo"
# replace the path above with your own path the to Flocking.nlogo program
NLLoadModel(nl.model)
sim <- function(vision,iterations){
  NLCommand(paste("set vision ", vision), "setup")
  NLCommand(paste("while [ticks < ", iterations), "] [go]")
  NLCommand("export-db")
  result <- NLReport("mean [deviation] of turtles")
  return(result)
}
sim(10,300)



  




NLQuit()
