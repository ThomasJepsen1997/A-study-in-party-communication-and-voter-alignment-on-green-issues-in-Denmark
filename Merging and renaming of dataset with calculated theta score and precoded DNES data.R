rm(list = ls())

library(plm)
library(esquisse)
library(ggplot2)
library(sjPlot)
library(ggeffects)
library(stargazer)
setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")

library(readxl)
diff_theta_party <- read_excel("diff_theta_party.xlsx", col_types = c("text", "numeric", "numeric"))
View(diff_theta_party)
library(estimatr)


load("C:/Users/Bruger/Desktop/Political Data Science/Final project/DNES_GroupMeans.rdata")

View(group.means)

group.means

## Renaming party names

group.means <- rename(group.means, Party = PartiStemme)

group.means$Party <- gsub("10", "Alternativet", group.means$Party )

group.means$Party <- gsub("9", "Enhedslisten", group.means$Party )

group.means$Party <- gsub("5", "Liberal Alliance", group.means$Party )

group.means$Party <- gsub("4", "SF", group.means$Party )

group.means$Party <- gsub("3", "Konservative", group.means$Party )

group.means$Party <- gsub("7", "Dansk Folkeparti", group.means$Party )

group.means$Party <- gsub("2", "Radikale Venstre", group.means$Party )

group.means$Party <- gsub("1", "Socialdemokratiet", group.means$Party )

group.means$Party <- gsub("8", "Venstre", group.means$Party )

#Now we merge the two datasets 

f_data <- merge(group.means, diff_theta_party, by= c("Year", "Party"))
view(f_data)



save(f_data, file = "final_data.Rda")