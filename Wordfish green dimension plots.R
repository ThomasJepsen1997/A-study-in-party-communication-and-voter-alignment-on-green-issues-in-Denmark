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






plot_wordfish_all_climate <- textplot_scale1d(
  wordfish_all_climate,
  margin = c("documents"),
  doclabels = (All_climate_merged_p$author_id) ,
  sort = TRUE,
  groups = (All_climate_merged_p$party),
  highlighted = NULL, 
  alpha = 0.7,
  highlighted_color = "black"
)


plot_wordfish_all_climate + labs(title = "Theta score of political parties tweets about the climate", 
                                 subtitle = "In election year of 2015 and 2019 with 95% confidence interval", 
                                 caption = "Source: Tweets from Danish political parties in parliament in both 2015 and 2019
                       Theta scores are estimated by running Wordfish with the quanteda.textplots package
     Plot produced using the ggplot2 package (Wickham, 2016)", ) +
  theme(axis.title = element_text())

####################################################################################################################
#Making a graph with theta scores of word
####################################################################################################################



summary(wordfish_all_climate)



xx <- textplot_scale1d(wordfish_all_climate, margin = "features",
                       highlighted = c("#klimatstrejk", "klima", "miljø", "#dkgreen", "#dkvind", "opvarmning", "job", "kød", "biodiversitet", "forurening", "energi", "co2", 
                                       "klimakrise", "bæredygtigt", "natur", "vindmøl", "grøn", "omstilling", "#dknatur", "klimakrise", "klimaforandringerne",
                                       "kul", "penge", "økonomi",  "olie", "planet", "global", "klimaminister", "fri", "pris", "vækst", "resultat", "klimahandling", "#grøntvalg", "skat", "klimakamp", 
                                       "#klimakamp", "plantebas", "spis", "brændsl", "klimakris", "grønt", "#klimakamp", "omstilling", "økologisk", "#deterheltsort", "sort", "videnskab", "klimaløsning",
                                       "madkultur", "finanslovsudspil", "belastning", "genopretning"))


xx + xlim(-1.5,1.5) + ylim(-3,5) + labs(title = "Word influence on party theta score and their relative frequencies",
                                        x = "Estimated Beta (weight)",
                                        y = "Estimated PSI (relative frequencies)",
                                        caption = "Source: Tweets from Danish political parties in parliament in both 2015 and 2019
                                        Beta and PSI are estimated using the quanteda package
                                        Plot produced using the ggplot2 package (Wickham, 2016)")


xx + xlim(-4.5,2.5) + ylim(-5,5.5) + labs(title = "Word influence on party theta score and their relative frequencies",
                                          x = "Estimated Beta (weight)",
                                          y = "Estimated PSI (relative frequencies)",
                                          caption = "Source: Tweets from Danish political parties in parliament in both 2015 and 2019
                                        Beta and PSI are estimated using the quanteda package
                                        Plot produced using the ggplot2 package (Wickham, 2016)")




zeta_wf <- wordfish_all_climate$beta*sqrt(exp(wordfish_all_climate$psi))
names(zeta_wf) <- colnames(tm_all_climate)


sort(zeta_wf,dec=T)[1:30]
sort(zeta_wf,dec=F)[1:30]

plot(wordfish_all_climate$psi,zeta_wf, col=rgb(0,0,0,.5), pch=19, cex=.5)
text(wordfish_all_climate$psi,zeta_wf, names(zeta_wf), pos=4, cex=.6)