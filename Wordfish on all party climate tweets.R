
rm(list = ls())


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


setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")


All_climate_2019 <-
  get_all_tweets (users = c("Spolitik", "venstredk", "LiberalAlliance", "SFpolitik", "radikale", "alternativet_", "DanskDf1995", 
                            "Enhedslisten", "KonservativeDK"),
                  start_tweets = "2018-06-05T00:00:00Z",
                  end_tweets = "2019-06-05T00:00:00Z",
                  data_path = "data/all_2019",
                  bind_tweets = FALSE,
                  n = Inf)
All_climate_2019 <- bind_tweets(data_path = "data/all_2019")


#Replacing names

All_climate_2019$author_id <- gsub("111554559", "Enhedslisten_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("17622853", "Liberal Allicance_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("28079017", "SF_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("7089792", "Konservative_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("1227448789", "Dansk Folkeparti_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("14462419", "Radikale Venstre_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("251034857", "Socialdemokratiet_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("123868861", "Venstre_2019", All_climate_2019$author_id )

All_climate_2019$author_id <- gsub("1704527995", "Alternativet_2019", All_climate_2019$author_id )


#Extracting the stuff we want

All_climate_2019_clean <- subset(All_climate_2019, select = c("author_id", "text"))

#Extracting tweets about the climate

All_climate_2019_sort <- All_climate_2019_clean %>% filter(grepl('klima|miljø|bæredygtigt|biodiversitet|natur|konservering|pesticid|landbrug|grøn|omstilling|kul|forurening
                                              |CO2|vindmøller|elbil|solceller|energi|strøm|opvarmning|#dkvind|#dkenergi|#dkgreen', text))
#Collapsing to one big tweet

All_climate_2019_colap <- All_climate_2019_sort %>%
  group_by(author_id) %>% summarise_all(paste, collapse = " ")

save(All_climate_2019_colap, file = "All_climate_2019_colap.rda")


################################################################################
#Same progress with data from 2015
################################################################################

All_climate_2015 <-
  get_all_tweets (users = c("Spolitik", "venstredk", "LiberalAlliance", "SFpolitik", "radikale", "alternativet_", "DanskDf1995", 
                            "Enhedslisten", "KonservativeDK"),
                  start_tweets = "2014-06-18T00:00:00Z",
                  end_tweets = "2015-06-18T00:00:00Z",
                  data_path = "data/all_2015",
                  bind_tweets = FALSE,
                  n = Inf)
All_climate_2015 <- bind_tweets(data_path = "data/all_2015")

#Replacing names

All_climate_2015$author_id <- gsub("111554559", "Enhedslisten_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("17622853", "Liberal Allicance_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("28079017", "SF_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("7089792", "Konservative_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("1227448789", "Dansk Folkeparti_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("14462419", "Radikale Venstre_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("251034857", "Socialdemokratiet_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("123868861", "Venstre_2015", All_climate_2015$author_id )

All_climate_2015$author_id <- gsub("1704527995", "Alternativet_2015", All_climate_2015$author_id )

#Extracting the stuff we want

All_climate_2015_clean <- subset(All_climate_2015, select = c("author_id", "text"))

#Extracting tweets about the climate

All_climate_2015_sort <- All_climate_2015_clean %>% filter(grepl('klima|miljø|bæredygtigt|biodiversitet|natur|konservering|pesticid|landbrug|grøn|omstilling|kul|forurening
                                              |CO2|vindmøller|elbil|solceller|energi|strøm|opvarmning|#dkvind|#dkenergi|#dkgreen', text))
#Collapsing to one big tweet

All_climate_2015_colap <- All_climate_2015_sort %>%
  group_by(author_id) %>% summarise_all(paste, collapse = " ")


################################################################################
#Now we merges the two datasets
################################################################################

All_climate_merged <- rbind(All_climate_2019_colap, All_climate_2015_colap)

#Mutating on a party variabel

All_climate_merged_p <- All_climate_merged %>% 
  mutate(party = case_when(author_id == c("Socialdemokratiet_2015", "Socialdemokratiet_2019")  ~ 'Socialdemokratiet',
                           author_id == "Enhedslisten_2015" ~ 'Enhedslisten',
                           author_id == "Enhedslisten_2019" ~ 'Enhedslisten',
                           author_id == "Liberal Allicance_2015" ~ 'Liberal Allicance',
                           author_id == "Liberal Allicance_2019" ~ 'Liberal Allicance',
                           author_id == "SF_2015" ~ 'SF',
                           author_id == "SF_2019" ~ 'SF',
                           author_id == "Konservative_2015"~ 'Konservative',
                           author_id == "Konservative_2019"~ 'Konservative',
                           author_id == c("Dansk Folkeparti_2015", "Dansk Folkeparti_2019")  ~ 'Dansk Folkeparti',
                           author_id == c("Radikale Venstre_2015", "Radikale Venstre_2019") ~ 'Radikale Venstre',
                           author_id == "Venstre_2015" ~ 'Venstre', 
                           author_id == "Venstre_2019" ~ 'Venstre',
                           author_id == "Alternativet_2015" ~ 'Alternativet',
                           author_id == "Alternativet_2019" ~ 'Alternativet'))

All_climate_merged_p 

save(All_climate_merged_p, file = "All_climate_merged_p.rda")

##################################################################################
#Now we can start our text analysis
#################################################################################



quanteda_corpus_all_climate <- quanteda::corpus(All_climate_merged_p) ## quanteda's corpus function

summary(quanteda_corpus_all_climate)

## 'tokenize' fulltext
texts_all_climate <- tokens(quanteda_corpus_all_climate, what = "word",
                  remove_numbers = T,
                  remove_punct = T,
                  remove_symbols = T,
                  remove_separators = T,
                  remove_hyphens = T,
                  remove_url = T,
                  verbose = T)


texts_all_climate <- tokens_tolower(texts_all_climate)
texts_all_climate <- tokens_remove(texts_all_climate, stopwords("danish"))
texts_all_climate <- tokens_wordstem(texts_all_climate) 
# get actual dfm from tokens
tm_all_climate <- dfm(texts_all_climate)


tm_all_climate <- dfm_trim(tm_all_climate, min_termfreq = 4)

# filter out one-character words
tm_all_climate <- tm_all_climate %>% dfm_select(min_nchar = 2)

wordfish_all_climate <- textmodel_wordfish(tm_all_climate, dir = c(1, 2))

summary(wordfish_all_climate)


   
