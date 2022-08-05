rm(list = ls())

setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")
devtools::install_github("lchiffon/wordcloud2")
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


load("C:/Users/Bruger/Desktop/Political Data Science/final project/All_climate_2019_colap.rda")

LA_clima_2019 <- All_climate_2019_colap[c(5), ] 

LA_clima_2019_corpus <- Corpus(VectorSource(LA_clima_2019))

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, content_transformer(tolower))

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, removeWords, stopwords("danish"))

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, 
                               content_transformer(specialChars))

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, removeWords, c("vore", "så", "uffeelbaek",
                                                                    "kan", "siger", "mere", "...",
                                                                    "helenehagel", "dag", "gøre", "rasmusnordqvist",
                                                                    "derfor", "lige", "bare", "kommer", "derforuff", "dkpol",
                                                                    "christianpol", "hele", "skriver", "carolinamai")) 

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, removeNumbers)

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, removePunctuation)

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, stripWhitespace)

LA_clima_2019_corpus <- tm_map(LA_clima_2019_corpus, stemDocument)



#making document matrix and dataframe 

dtml <- TermDocumentMatrix(LA_clima_2019_corpus)

ml <- as.matrix(dtml)
vl <- sort(rowSums(ml),decreasing=TRUE)
dl <- data.frame(word = names(vl),freq=vl)

colour = c("#022747", "#ecb444")
background = "#ffffff"

wordcloud2(dl, figPath = "t.png",
           color = rep_len(colour, nrow(dl)),
           backgroundColor = background)






