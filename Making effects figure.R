
rm(list = ls())

library(plm)
library(esquisse)
library(ggplot2)
library(sjPlot)
library(ggeffects)
library(stargazer)
library(tidyverse)
setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")







mydf_miljoe <- ggpredict(m3_miljoe, terms = "theta_score",  
                         vcov.fun = "vcovCL", vcov.type = "HC1",vcov.args = list(cluster = f_data$Party))

ggplot(mydf_miljoe)

plot(mydf_miljoe) + labs(title  =  "Predicted values of parties mean voter atitude towards enviromental improvement must not harm the competitivneness of business",
                         subtitle = "on different levels of party theta score on the green dimension with 95% confidence intervals",
                         caption = "Note: Based on model 6 in table 1. Plot has been made using ggpredict in the ggplot2 package (Wicham, 2016)") + 
  xlab("Parties theta score on the green dimension") + ylab("Voters attitude towards enviromental improvement") + theme_gray()