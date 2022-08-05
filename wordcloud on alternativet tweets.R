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


load("C:/Users/Bruger/Desktop/Political Data Science/final project/All_climate_2019_colap.rda")

AL_clima_2019 <- All_climate_2019_colap[c(1), ] 

AL_clima_2019_corpus <- Corpus(VectorSource(AL_clima_2019))

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, content_transformer(tolower))

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, removeWords, stopwords("danish"))

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, 
                        content_transformer(specialChars))

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, removeWords, c("vore", "så", "uffeelbaek",
                                                                    "kan", "siger", "mere", "...",
                                                                    "helenehagel", "dag", "gøre", "rasmusnordqvist",
                                                                    "derfor", "lige", "bare", "kommer", "derforuff", "dkpol")) 

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, removeNumbers)

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, removePunctuation)

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, stripWhitespace)

AL_clima_2019_corpus <- tm_map(AL_clima_2019_corpus, stemDocument)



#making document matrix and dataframe 

dtm <- TermDocumentMatrix(AL_clima_2019_corpus)

m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)



wordcloud2(d, figPath = "t.png", color='skyblue', minSize = 1.5, size = 3)
wordcloud2(d, figPath = "t.png", color='skyblue')

wordcloud2(d, "R")
letterCloud(d,"R")



