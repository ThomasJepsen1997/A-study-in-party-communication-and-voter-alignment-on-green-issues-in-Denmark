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






#Plotting


plot_wordfish_press_twitter <- textplot_scale1d(
  wordfish_press_twitter,
  margin = c("documents"),
  doclabels = (Press_twitter$Press_or_tweet) ,
  sort = TRUE,
  groups = (Press_twitter$party),
  highlighted = NULL, 
  alpha = 0.7,
  highlighted_color = "black"
)


plot_wordfish_press_twitter + labs(title = "Comparison between theta scores for parties press releases and tweets", 
                                   subtitle = "In the time period one year up to the 2019 election with 95% confidence interval", 
                                   caption = "Source: Tweets from Danish political parties in parliament in 2019-18 and press releases from the website of the respective parties
                       Theta scores are estimated by running Wordfish with the quanteda.textplots package
     Plot produced using the ggplot2 package (Wickham, 2016)", ) +
  theme(axis.title = element_text())


x <- textplot_scale1d(wordfish_press_twitter, margin = "features",
                      highlighted = c("#klimatstrejk", "klima", "miljø", "#dkgreen", "#dkvind", "opvarmning", "job", "kød", "biodiversitet", "forurening", "energi", "co2", 
                                      "klimakrise", "bæredygtigt", "natur", "vindmøl", "grøn", "omstilling", "#dknatur", "klimakrise", "klimaforandringerne",
                                      "kul", "penge", "økonomi",  "olie", "planet", "global", "klimaminister", "fri", "pris", "vækst", "resultat", "klimahandling", "#grøntvalg", "skat", "klimakamp", 
                                      "#klimakamp", "plantebas", "spis", "brændsl", "klimakris", "grønt", "#klimakamp", "omstilling", "økologisk", "#deterheltsort", "sort", "videnskab", "klimaløsning",
                                      "madkultur", "finanslovsudspil", "belastning", "genopretning"))


zeta2_wf <- wordfish_press_twitter$beta*sqrt(exp(wordfish_press_twitter$psi))
names(zeta2_wf) <- colnames(tm_press_twitter)


sort(zeta2_wf,dec=T)[1:30]
sort(zeta2_wf,dec=F)[1:30]

