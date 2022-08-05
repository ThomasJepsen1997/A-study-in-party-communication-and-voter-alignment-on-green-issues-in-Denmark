rm(list = ls())

library(plm)
library(esquisse)
library(ggplot2)
library(sjPlot)
library(ggeffects)
library(stargazer)
setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")


load("final_data.Rda")

plot(f_data$theta_score, f_data$mean_ForbedreMiljoe)

plot(f_data$theta_score, f_data$mean_ForbedreMiljoe)

ggplot(f_data) +
  aes(x = theta_score, y = mean_ForbedreMiljoe) +
  geom_point(shape = "circle", size = 2.8, colour = "#112446") +
  geom_smooth() +
  labs(
    x = "Parties theta score",
    y = "Economic growth is more important than the environment",
    title = "Correlation between parties theta score on the green dimension and voters attitude towards 
that economic growth is more important than the environment",
    caption = "Source: Theta scores calculated from party tweets regarding the greendimionsion. 
    Voters attiude towards enviroment protection is extracted from the DNES project
    Plot is made using the ggplot package") +
  theme_light() +
  theme(plot.title = element_text(size = 17L))



ggplot(f_data) +
  aes(x = theta_score, y = mean_OekonomiskVaekst) +
  geom_point(shape = "circle", size = 2.8, colour = "#112446") +
  geom_smooth() +
  labs(
    x = "Parties theta score",
    y = "Environmental improvement mustn't harm the competitiveness of business",
    title = "Correlation between parties theta score on the green dimension and voters attitude towards 
that environmental improvement mustn't harm the competitiveness of business",
    caption = "Source: Theta scores calculated from party tweets regarding the greendimionsion. 
    Voters attiude towards enviroment protection is extracted from the DNES project
    Plot is made using the ggplot package") +
  theme_light() +
  theme(plot.title = element_text(size = 17L))


curve_values <-  loess(f_data$mean_ForbedreMiljoe ~ f_data$theta_score) 

lines(lowess(f_data$theta_score, f_data$mean_ForbedreMiljoe), col='red')
lines(lowess(f_data$theta_score, f_data$mean_ForbedreMiljoe, f=3), col='red')