rm(list = ls())

setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")

#Loading party press into the enviroment 

load("C:/Users/Bruger/Desktop/Political Data Science/Final project/Alternativet_press.rda")
load("C:/Users/Bruger/Desktop/Political Data Science/Final project/Dansk_Folkeparti_press.rda")
load("C:/Users/Bruger/Desktop/Political Data Science/Final project/Enhedslisten_press.rda")
load("C:/Users/Bruger/Desktop/Political Data Science/Final project/SF_press.rda")
load("C:/Users/Bruger/Desktop/Political Data Science/Final project/Konservative_press.rda")

########################################################################
#Colapsing all to one big text
#######################################################################

#Alternativet

Alternativet_presse <- Alternativet_presse %>%
  group_by(Party) %>% summarise_all(paste, collapse = " ")

Alternativet_presse <- Alternativet_presse %>%
  group_by(Party) %>% summarise_all(paste, collapse = " ")

Alternativet_presse<- subset(Alternativet_presse, select = c("Text", "Party"))

Alternativet_presse<- rename(Alternativet_presse, text = Text)

#Dansk Folkeparti

DF_presse<- subset(dat_DF, select = c("text"))
DF_presse<- mutate(DF_presse, Party = "Dansk Folkeparti Press release")

DF_presse <- DF_presse %>%
  group_by(Party) %>% summarise_all(paste, collapse = " ")

#Konservative 

Konservative_presse<- subset(dat_k, select = c("text"))
Konservative_presse<- mutate(Konservative_presse, Party = "Konservative Press release")

Konservative_presse <- Konservative_presse %>%
  group_by(Party) %>% summarise_all(paste, collapse = " ")

#SF

SF_presse<- subset(dat_SF, select = c("text"))
SF_presse<- mutate(SF_presse, Party = "SF Press release")

SF_presse <- SF_presse %>%
  group_by(Party) %>% summarise_all(paste, collapse = " ")

#Enhedslisten

Enhedslisten_presse<- subset(dat_Ø, select = c("text"))
Enhedslisten_presse<- mutate(Enhedslisten_presse, Party = "Enhedslisten Press release")

Enhedslisten_presse <- Enhedslisten_presse %>%
  group_by(Party) %>% summarise_all(paste, collapse = " ")

#Binding to one dataframe

Press_release <- rbind(Enhedslisten_presse, SF_presse, Konservative_presse,DF_presse, Alternativet_presse)

#Saving 

save(Press_release, file = "Press_release.rda")

