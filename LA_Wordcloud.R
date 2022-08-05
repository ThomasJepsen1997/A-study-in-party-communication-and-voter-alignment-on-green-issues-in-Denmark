rm(list = ls())

setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")
library(devtools)
library(rtools)
install.packages("devtools")
library(wordcloud2)
install.packages("rtools")


library(tidyverse)
library(quanteda)
library(quanteda.textmodels)
library(academictwitteR)
library(dplyr)
library(quanteda.textplots)
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
library(topicmodels)
library(lubridate)
library(textmineR)
library(stm)


load("LA_clima_2019_corpus")


dtml <- TermDocumentMatrix(LA_clima_2019_corpus)

ml <- as.matrix(dtml)
vl <- sort(rowSums(ml),decreasing=TRUE)
dl <- data.frame(word = names(vl),freq=vl)

colour = c("#022747", "#ecb444")
background = "#ffffff"

wordcloud2(dl, figPath = "t.png",
           color = rep_len(colour, nrow(dl)),
           backgroundColor = background)