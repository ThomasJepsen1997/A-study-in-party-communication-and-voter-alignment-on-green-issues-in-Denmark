rm(list = ls())

library(plm)
library(esquisse)
library(ggplot2)
library(sjPlot)
library(ggeffects)
library(stargazer)
setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")


#######################################################################
# MAKING REGRGRESSION TABLE
##################################################################

stargazer(m1_vaekst, m2_vaekst, m3_vaekst, m1_miljoe, m2_miljoe, m3_miljoe, # all regression model objects
          dep.var.labels = c("Economic growth is more important than the environment", "Environmental improvement mustn't harm the competitiveness of business"), # label DVs
          column.labels = c("Without FE", "FE", "FE with control", "Without FE", "FE", "FE with control"), # col labels (here, for models)
          column.separate = c(1, 1), # apply column labels (see help file)
          title = "Main models of theta score on average voter attitude towards issues on the green dimension", # Main title for table
          covariate.labels=c("Theta Score", "Gender", "Age", "Political Interest"),
          align = TRUE, # align the decimal places?? (yes)
          no.space = F, # remove empty lines from table
          omit.stat = c("LL","ser","f",),
          omit = ("Party")),





