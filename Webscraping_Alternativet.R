setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")

library(readxl)

Alternativet_presse <- read_excel("Alternativet presse.xlsx", col_types = c("text", "text", "text"))

View(Alternativet_presse)

save(Alternativet_presse, file = "Alternativet_press.rda")
