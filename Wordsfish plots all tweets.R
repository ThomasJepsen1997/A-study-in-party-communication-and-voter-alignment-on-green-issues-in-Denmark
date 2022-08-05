rm(list = ls())

library(tidyverse)
library(quanteda)
library(quanteda.textmodels)
library(academictwitteR)
library(quanteda)
library(dplyr)
library(quanteda.textplots)



plot_wordfish <- textplot_scale1d(
  wordfish_first,
  margin = c("documents"),
  doclabels = (quanteda_corpus$author_id) ,
  sort = TRUE,
  groups = NULL,
  highlighted = NULL,
  alpha = 0.7,
  highlighted_color = "black"
)


plot_wordfish + labs(title = "Theta score of political parties", 
                     subtitle = "Aggregated of the period 2018-06-05 - 2019-06-05", 
                     caption = "Source: Tweets from Danish political parties in parliament in both 2015 and 2019
                       Theta scores are estimated by running Wordfish with the quanteda.textplots package
     Plot produced using the ggplot2 package (Wickham, 2016)", )  +
  theme(axis.title = element_text())

textplot_scale1d(wordfish_first, margin = "features", 
                 highlighted = c("klima", "#dkpol", "#dkgreen", "miljø", "bæredygtigt", "økonomi", "omstilling", "danmark", "valg", "udsatte", "Udlænding", "indvandring", "skat"))



####################################################
#Trying making a different plot
####################################################

ggplot(mapping = aes(y = wordfish_first$theta, x = Time_clean_data_colap$block, color=Time_clean_data_colap$author_id)) + geom_point(size=4) +
  labs(x = "Block", y = "Wordfish theta score", title = "Theta score of political parties distributed on party block",  
       subtitle = "Aggregated of the period 2018-06-05 - 2019-06-05", caption = "Source: Tweets from Danish political parties in parliament in both 2015 and 2019
                       Theta scores are estimated by running Wordfish with the quanteda.textplots package
     Plot produced using the ggplot2 package (Wickham, 2016)") + guides(col = guide_legend(title = "Party")) + theme_bw()











