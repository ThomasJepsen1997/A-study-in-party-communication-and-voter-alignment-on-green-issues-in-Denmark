rm(list = ls())


#Load survey data from 2015 and 2019
load("/Users/Thomas/Downloads/Valgundersõgelserne 1971-2019/Valgundersõgelsen 2015 (DDA-31083)/Data/R/data31083.rdata")
load("/Users/Thomas/Downloads/Valgundersõgelserne 1971-2019/Valgundersõgelsen 2019/Data/R/Valg2019.rdata")

#Load R-packages
library(ggplot2)
library(tidyverse)
library(dplyr)
# create empty data set with titles
cols <- c("PartyPreference2015", "ForbedreMiljoe", "OekonomiskVaekst", "PartyPosition", "PoliticalKnowledge", "Vote2019", "Age", "Gender", "PartyFollower", "Year")
dat <- cols %>% t %>% as_tibble(.name_repair = "unique") %>% `[`(0, ) %>% rename_all(~cols)

########################
###### data munging 2015
########################

#Selecting interesting variables
myvars <-c("V5", "V6", "V26", "V51", "V87", "V88", "V182", "V183")
dat15 <-data31083[myvars]

#Renaming ze variables
dat15<-dat15 %>% rename ("Gender"="V5", "Fødselsår"="V6", "PolitiskInteresse"="V26",
                          "PartiStemme"="V51", "TilhængerAfParti"="V87" 
                            ,"V88_PartiTilhænger"="V88", "OekonomiskVaekst_Miljoe"="V182", 
                              "ForbedreMiljoe"="V183")

#Adding a variable to show the year the survey is from
dat15<-dat15 %>% mutate(Year=2015)
#Beregner alder af respondenter
dat15<-dat15 %>% mutate(Age=2015-Fødselsår)

#Omkodning af variable til rigtige værdier og fjernelse af missing, ved ikke og irrelevante svar
dat15 <-filter(dat15, !ForbedreMiljoe ==(8))
dat15 <-filter(dat15, !OekonomiskVaekst_Miljoe ==(8))

cor(dat15$ForbedreMiljoe, dat15$OekonomiskVaekst_Miljoe)

hist(dat15$ForbedreMiljoe)
hist(dat15$OekonomiskVaekst_Miljoe)

#Hvem man stemte på i 2015
dat15 <- filter(dat15, !PartiStemme ==(99))
dat15 <- filter(dat15, !PartiStemme ==(88))
dat15 <- filter(dat15, !PartiStemme ==(13))
dat15 <- filter(dat15, !PartiStemme ==(12))
dat15 <- filter(dat15, !PartiStemme ==(11))
dat15 <- filter(dat15, !PartiStemme ==(6))
hist(dat15$PartiStemme)

####### Finder Gennemsnit og Kvartiler #############
summary(dat15$ForbedreMiljoe)
summary(dat15$OekonomiskVaekst_Miljoe)

#########################
####### data munging 2019
#########################

#Selecting interesting variables
myvars <-c( "q18", "q12", "q54_6_resp", "q54_7_resp", "q28", "q29", "q1", "q2", "q60_1_resp", "q60_2_resp")
dat19 <-Valg2019[myvars]

#Renaming ze variables
dat19<-dat19 %>% rename ("Gender"="q1", "Fødselsår"="q2", "PolitiskInteresse"="q12",
                         "PartiStemme"="q18", "TilhængerAfParti"="q28" 
                         ,"Q29_PartiTilhænger"="q29", "OekonomiskVaekst_Miljoe"="q54_6_resp", 
                         "ForbedreMiljoe"="q54_7_resp", "KlimaSkat"="q60_2_resp", "KlimaUdfordring"="q60_1_resp")

#Adding a variable to show the year the survey is from
dat19<-dat19 %>% mutate(Year=2019)
#Beregner alder af respondenter
dat19<-dat19 %>% mutate(Age=2019-Fødselsår)

#Omkodning af variable til rigtige værdier og fjernelse af missing, ved ikke og irrelevante svar
#Klima og Miljø spørgsmål
dat19$KlimaUdfordring <- as.numeric(recode(dat19$KlimaUdfordring, '1'='5', '2'='4', '3'='3', '4'='2', '5'='1'))
dat19$KlimaSkat <- as.numeric(recode(dat19$KlimaSkat, '5'='1', '4'='2', '3'='3', '2'='4', '1'='5'))

dat19 <-filter(dat19, !ForbedreMiljoe ==(6))
dat19 <-filter(dat19, !OekonomiskVaekst_Miljoe ==(6))
dat19 <-filter(dat19, !KlimaSkat ==(6))
dat19 <-filter(dat19, !KlimaUdfordring ==(6))

hist(dat19$ForbedreMiljoe)
hist(dat19$OekonomiskVaekst_Miljoe)
hist(dat19$KlimaSkat)
hist(dat19$KlimaUdfordring)
hist(Valg2019$q54_7_resp)


#Hvem man stemte på i 2015
dat19 <- filter(dat19, !PartiStemme ==(18))
dat19 <- filter(dat19, !PartiStemme ==(17))
dat19 <- filter(dat19, !PartiStemme ==(16))
dat19 <- filter(dat19, !PartiStemme ==(15))
dat19 <- filter(dat19, !PartiStemme ==(14))
dat19 <- filter(dat19, !PartiStemme ==(10))
dat19 <- filter(dat19, !PartiStemme ==(8))
dat19 <- filter(dat19, !PartiStemme ==(5))
dat19 <- filter(dat19, !PartiStemme ==(4))
hist(dat19$PartiStemme)
dat19$PartiStemme <- as.numeric(gsub("6", "4", dat19$PartiStemme))
dat19$PartiStemme <- as.numeric(gsub("7", "5", dat19$PartiStemme))
dat19$PartiStemme <- as.numeric(gsub("9", "7", dat19$PartiStemme))
dat19$PartiStemme <- as.numeric(gsub("11", "8", dat19$PartiStemme))
dat19$PartiStemme <- as.numeric(gsub("12", "9", dat19$PartiStemme))
dat19$PartiStemme <- as.numeric(gsub("13", "10", dat19$PartiStemme))
hist(dat15$PolitiskInteresse)
###########################################################################
### Validering af den grønne dimension fra vælgernes holdninger
### Sammenligning mellem forskellige spørgsmål - Correlation or scatter plot
### Item-Item analyse
###########################################################################

#Spørgsmål om klima: Klimaforandringerne er vor tids største udfordring (q60_1_resp) + 
# Der bør indføres en skat på CO2-udledning for at bremse klimaforandringerne (q60_2_resp)

cor(dat19[ ,c("ForbedreMiljoe", "OekonomiskVaekst_Miljoe", "KlimaUdfordring", "KlimaSkat")])

####### Finder Gennemsnit og Kvartiler #############
summary(dat19$ForbedreMiljoe)
summary(dat19$OekonomiskVaekst_Miljoe)

######################################################################
########## Merger mine datasæt og laver forskellige typer af merges.
######################################################################

## Simpel datasæt med opdeling ud fra surveyåret.
dat15<- lapply(dat15,as.numeric)
dat19<- lapply(dat19,as.numeric)
z <- bind_rows(dat15,dat19)
z=subset(z, select = -c(V88_PartiTilhænger, Fødselsår, KlimaSkat, KlimaUdfordring, Q29_PartiTilhænger))


## Datasæt aggregeret ud fra hvert parti og survey år.
group.means <- z %>% group_by (Year, PartiStemme) %>% dplyr::summarise(mean_ForbedreMiljoe = mean(ForbedreMiljoe), mean_OekonomiskVaekst = mean(OekonomiskVaekst_Miljoe), mean_Gender = mean(Gender), mean_Age = mean(Age), mean_PolitiskInteresse = mean(PolitiskInteresse), mean_tilhængerafparti = mean(TilhængerAfParti))
z <- na.omit(z)

save(group.means, file = "DNES_GroupMeans.RData")
save(t, file = "KompletDatasæt.RData")
