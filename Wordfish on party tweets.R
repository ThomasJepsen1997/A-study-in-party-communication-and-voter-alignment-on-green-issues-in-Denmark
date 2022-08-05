
rm(list = ls())

library(tidyverse)
library(quanteda)
library(quanteda.textmodels)
library(academictwitteR)
library(quanteda)
library(dplyr)
library(quanteda.textplots)

setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")

Time20182019_tweets <-
  get_all_tweets (users = c("Spolitik", "venstredk", "LiberalAlliance", "SFpolitik", "radikale", "alternativet_", "DanskDf1995", 
                            "Enhedslisten", "KonservativeDK"),
                  start_tweets = "2018-06-05T00:00:00Z",
                  end_tweets = "2019-06-05T00:00:00Z",
                  data_path = "data/2018-19",
                  bind_tweets = FALSE,
                  n = Inf)

Time20182019_tweets <- bind_tweets(data_path = "data/2018-19")

save(Time20182019_tweets, file = "Time20182019_tweets")


#Replacing numbers with party names

Time20182019_tweets$author_id <- gsub("111554559", "Enhedslisten", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("17622853", "Liberal Allicance", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("28079017", "SF", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("7089792", "Konservative", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("1227448789", "Dansk Folkeparti", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("14462419", "Radikale Venstre", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("251034857", "Socialdemokratiet", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("123868861", "Venstre", Time20182019_tweets$author_id )

Time20182019_tweets$author_id <- gsub("1704527995", "Alternativet", Time20182019_tweets$author_id )



Time_clean_data <- subset(Time20182019_tweets, select = c("author_id", "text"))




Time_clean_data_colap <- Time_clean_data %>%
  group_by(author_id) %>% summarise_all(paste, collapse = " ")


##Setting a party as left or right block

Time_clean_data_colap <- Time_clean_data_colap %>% 
  mutate(block = case_when(author_id == "Socialdemokratiet" ~ 'Left',
                           author_id == "Enhedslisten" ~ 'Left',
                           author_id == "Liberal Allicance" ~ 'Right',
                           author_id == "SF" ~ 'Left',
                           author_id == "Konservative" ~ 'Right',
                           author_id == "Dansk Folkeparti"  ~ 'Right',
                           author_id == "Radikale Venstre" ~ 'Left',
                           author_id == "Venstre" ~ 'Right',
                           author_id == "Alternativet" ~ 'Left'))

save(Time_clean_data_colap, file = "Party_tweet_2019.rda")


quanteda_corpus <- quanteda::corpus(Time_clean_data_colap) ## quanteda's corpus function

summary(quanteda_corpus)

## 'tokenize' fulltext
texts <- tokens(quanteda_corpus, what = "word",
                remove_numbers = T,
                remove_punct = T,
                remove_symbols = T,
                remove_separators = T,
                remove_hyphens = T,
                remove_url = T,
                verbose = T)


texts <- tokens_tolower(texts)
texts <- tokens_remove(texts, stopwords("danish"))
texts <- tokens_wordstem(texts) 

# get actual dfm from tokens
tm <- dfm(texts)


tm <- dfm_trim(tm, min_termfreq = 4)

# filter out one-character words
tm <- tm %>% dfm_select(min_nchar = 2)

summary(tm)

wordfish_first <- textmodel_wordfish(tm, dir = c(1, 2))

summary(wordfish_first)




