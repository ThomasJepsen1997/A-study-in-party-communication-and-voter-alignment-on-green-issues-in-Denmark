

rm(list = ls())
setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")

library(tidyverse)
library(quanteda)
library(quanteda.textmodels)
library(academictwitteR)
library(quanteda)
library(dplyr)
library(quanteda.textplots)
library(tidyverse)
library(academictwitteR)
library(quanteda)
quanteda_options("language_stemmer" = "danish")
library(lubridate)
library(topicmodels)
library(ggplot2)
library(xts)
library(dplyr)
library(rtweet)
library(tsbox)
library(scales)
library(tidytext)
library(ggthemes)


load("C:/Users/Bruger/Desktop/Political Data Science/Final project/Press_release.rda")
load("C:/Users/Bruger/Desktop/Political Data Science/Final project/Party_tweet_2019.rda")

#Taking the parties we want 

Party_tweets_2019 <- Time_clean_data_colap[-c(5, 6, 8, 9), ]

#Renaming 

Party_tweets_2019$author_id <- gsub("Enhedslisten", "Enhedslisten Tweet", Party_tweets_2019$author_id )

Party_tweets_2019$author_id <- gsub("SF", "SF Tweet", Party_tweets_2019$author_id )

Party_tweets_2019$author_id <- gsub("Konservative", "Konservative Tweet", Party_tweets_2019$author_id )

Party_tweets_2019$author_id <- gsub("Dansk Folkeparti", "Dansk Folkeparti Tweet", Party_tweets_2019$author_id )

Party_tweets_2019$author_id <- gsub("Alternativet", "Alternativet Tweet", Party_tweets_2019$author_id )

Party_tweets_2019 <- rename(Party_tweets_2019, Party = author_id)

#taking out block data

Party_tweets_2019 <- subset(Party_tweets_2019, select = c("Party", "text"))

#Binding the two dataset

Press_twitter <- rbind(Party_tweets_2019, Press_release)

Press_twitter <- rename(Press_twitter, Press_or_tweet = Party)

#Mutating 

Press_twitter <- Press_twitter %>% 
  mutate(party = case_when(Press_or_tweet == "Enhedslisten Press release" ~ 'Enhedslisten',
                           Press_or_tweet == "Enhedslisten Tweet" ~ 'Enhedslisten',
                           Press_or_tweet == "SF Tweet" ~ 'SF',
                           Press_or_tweet == "SF Press release" ~ 'SF',
                           Press_or_tweet == "Konservative Tweet" ~ 'Konservative',
                           Press_or_tweet == "Konservative Press release" ~ 'Konservative',
                           Press_or_tweet == "Dansk Folkeparti Press release" ~ 'Dansk Folkeparti',
                           Press_or_tweet == "Dansk Folkeparti Tweet" ~ 'Dansk Folkeparti',
                           Press_or_tweet == "Alternativet Press release" ~ 'Alternativet',
                           Press_or_tweet == "Alternativet Tweet" ~ 'Alternativet'))

#########################################################################################
#Starting text analysis 
#########################################################################################

quanteda_corpus_press_twitter <- quanteda::corpus(Press_twitter) ## quanteda's corpus function

summary(quanteda_corpus_press_twitter)

## 'tokenize' fulltext
texts_press_twitter <- tokens(quanteda_corpus_press_twitter, what = "word",
                            remove_numbers = T,
                            remove_punct = T,
                            remove_symbols = T,
                            remove_separators = T,
                            remove_hyphens = T,
                            remove_url = T,
                            verbose = T)


texts_press_twitter <- tokens_tolower(texts_press_twitter)
texts_press_twitter <- tokens_remove(texts_press_twitter, stopwords("danish"))
texts_press_twitter <- tokens_wordstem(texts_press_twitter) 
# get actual dfm from tokens
tm_press_twitter <- dfm(texts_press_twitter)


tm_press_twitter <- dfm_trim(tm_press_twitter, min_termfreq = 4)

# filter out one-character words
tm_press_twitter <- tm_press_twitter %>% dfm_select(min_nchar = 2)

wordfish_press_twitter <- textmodel_wordfish(tm_press_twitter, dir = c(1, 9))
wordfish_press_twitter <- textmodel_wordfish(tm_press_twitter)
summary(wordfish_press_twitter)

