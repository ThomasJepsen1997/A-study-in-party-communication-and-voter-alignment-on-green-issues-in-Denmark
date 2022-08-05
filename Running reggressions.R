
rm(list = ls())

library(plm)
library(esquisse)
library(ggplot2)
library(sjPlot)
library(ggeffects)
library(stargazer)
setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")




load("final_data.Rda")


#Making normal linear regressen

# Normal-Linear model 
m1_vaekst <- lm(mean_OekonomiskVaekst ~ theta_score,
                data = f_data)
summary(m1_vaekst)
plot(m1_vaekst)
plot(m1_vaekst ,which = 1)



m2_vaekst <-lm(mean_OekonomiskVaekst ~ theta_score + factor(Party), data = f_data)

summary(m2_vaekst)
plot(m2_vaekst)


m3_vaekst <-lm(mean_OekonomiskVaekst ~ theta_score + mean_Gender + mean_Age + mean_PolitiskInteresse + factor(Party), data = f_data)

summary(m3_vaekst)
plot(m3_vaekst)



###########################################################################################
#Forbedret miljø
##########################################################################################


m1_miljoe <- lm(mean_ForbedreMiljoe ~ theta_score,
                data = f_data)
summary(m1_miljoe)




m2_miljoe <-lm(mean_ForbedreMiljoe ~ theta_score + factor(Party), data = f_data) 


summary(m2_miljoe)

plot(m2_miljoe)







m3_miljoe <-lm(mean_ForbedreMiljoe ~ theta_score + mean_Gender + mean_Age + mean_PolitiskInteresse + factor(Party), data = f_data)


summary(m3_miljoe)

plot(m3_miljoe)


