
rm(list = ls())

setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")
#Load packages 

library(tidyverse)
library(httr)
library(rvest)
library(jsonlite)
library(dplyr)
library(data.table)
library(tidytext)
library(manifestoR)
library(tm)
library(ggplot2)
library(expss)
library(quanteda)
library(topicmodels)
library(lubridate)
library(textmineR)
library(stm)
library(readxl)
library(scales)

#Getting dataset with theta scores in 2019

theta_score_2019 <- read_excel("theta score 2019.xlsx", col_types = c("text", "numeric"))
View(theta_score_2019)

#Getting data from manifesto api

#Setting my API key

mp_setapikey("C:/Users/Bruger/Desktop/Political Data Science/Final project/manifesto_apikey.txt")

my_corpus <- mp_corpus(countryname == "Denmark") 

(mpds <- mp_maindataset())

ideo_scal <- mpds %>%
  filter(countryname == "Denmark")  %>%
  mutate(ideo = mp_scale(.)) %>%
  select(partyname, edate, ideo)

Score_2019 <- ideo_scal %>% filter(edate == "2019-06-05")

Score_2019

Score_2019 <- rename(Score_2019, Party = partyname)

#Replacing english names for danish

Score_2019$Party <- gsub("Red-Green Unity List", "Enhedslisten", Score_2019$Party )

Score_2019$Party <- gsub("Liberal Alliance", "Liberal Alliance", Score_2019$Party )

Score_2019$Party <- gsub("Socialist People's Party", "SF", Score_2019$Party )

Score_2019$Party <- gsub("Conservative People's Party", "Konservative", Score_2019$Party )

Score_2019$Party <- gsub("Danish People's Party", "Dansk Folkeparti", Score_2019$Party )

Score_2019$Party <- gsub("Danish Social-Liberal Party", "Radikale Venstre", Score_2019$Party )

Score_2019$Party <- gsub("Social Democratic Party", "Socialdemokratiet", Score_2019$Party )

Score_2019$Party <- gsub("Liberals", "Venstre", Score_2019$Party )

Score_2019$Party <- gsub("Alternativ", "Alternativet", Score_2019$Party )



#Removing "Nye Borgerlige"

Score_2019 <- Score_2019[-c(10), ]

#Merging the two datasets

merge_theta_CMD <- merge(Score_2019, theta_score_2019, by ="Party")

#rescaling theta and ideo

merge_theta_CMD$ideo <- rescale(merge_theta_CMD$ideo)
merge_theta_CMD$theta_2019 <- rescale(merge_theta_CMD$theta_2019)

merge_theta_CMD

#Making a ggplot 

library(reshape2)

merge_theta_CMD_meltes <- melt(merge_theta_CMD[,c('Party','ideo','theta_2019')],id.vars = 1)

ggplot(merge_theta_CMD_meltes,aes(x = Party,y = value)) + 
  geom_bar(aes(fill = variable),stat = "identity",position = "dodge") 

###################################################################################3
#Trying to make a different comparisson plot 
#################################################################################

library(ggalt)
install.packages("corrplot")
library(corrplot)
theme_set(theme_fivethirtyeight())

merge_theta_CMD$Party <- factor(merge_theta_CMD$Party, levels=as.character(merge_theta_CMD$Party))


gg <- ggplot(merge_theta_CMD, aes(x=ideo, xend=theta_2019, y=reorder(Party, ideo), group=Party)) + 
  geom_dumbbell(color="#a3c4dc", 
                size=1,
                colour_x ="#e8000d",
                colour_xend = "#1da1f3",
                size_x = 3, size_xend = 3) + labs(y=NULL,
                                                      title="Comparison between CMP and Wordfish scores", 
                                                      subtitle="Scores are rescaled -1 to 1",
                                                      caption="Source: Wordfish score from tweets by Danish political parties in parliament one year up the election
                                                      in 2019 and ideological CMP score made on the basis of political manifestos published in june 2019. 
                                                      Scores are in both cases rescaled -1 to 1. Plot produced using the ggplot2 package (Wickham, 2016)") + 
  geom_text(data=merge_theta_CMD,aes(x=0.5097458, y= "Liberal Alliance", label="CMP"), color="#e8000d", hjust=1, size=5, nudge_x=-0.2) + 
  geom_text(data=merge_theta_CMD, aes(x=0.6411852, y= "Liberal Alliance", label="Wordfish"), color="#1da1f3", hjust=0, size=5, nudge_x=0.2)


plot(gg)





























