
PRESS <- function(linear.model) {
  #' calculate the predictive residuals
  pr <- residuals(linear.model)/(1-lm.influence(linear.model)$hat)
  #' calculate the PRESS
  PRESS <- sum(pr^2)
  
  return(PRESS)
}


pred_r_squared <- function(linear.model) {
  #' Use anova() to get the sum of squares for the linear model
  lm.anova <- anova(linear.model)
  #' Calculate the total sum of squares
  tss <- sum(lm.anova$'Sum Sq')
  # Calculate the predictive R^2
  pred.r.squared <- 1-PRESS(linear.model)/(tss)
  
  return(pred.r.squared)
}

model_fit_stats <- function(linear.model) {
  r.sqr <- summary(linear.model)$r.squared
  adj.r.sqr <- summary(linear.model)$adj.r.squared
  ratio.adjr2.to.r2 <- (adj.r.sqr/r.sqr)
  pre.r.sqr <- pred_r_squared(linear.model)
  press <- PRESS(linear.model)
  return.df <- data.frame("R-squared" = r.sqr, "Adj R-squared" = adj.r.sqr, 
                          "Ratio Adj.R2 to R2" = ratio.adjr2.to.r2, "Pred R-squared" = pre.r.sqr, PRESS = press)
  return(round(return.df,3))
}

library(plyr)


ldply(list(m1_miljoe, m2_miljoe, m3_miljoe), model_fit_stats)



prs <- ldply(list(m1_miljoe, m2_miljoe, m3_miljoe), model_fit_stats)

pr2 <- rbind(prs$Pred.R.squared[1], prs$Pred.R.squared[2], prs$Pred.R.squared[3])

max_pr2 <- max(pr2) ### this calculates the highest predictive R-squared, which is then plotted as a red line.

barplot(c("Model 4"=prs$Pred.R.squared[1], "Model 5"=prs$Pred.R.squared[2], "Model 6"=prs$Pred.R.squared[3]),
        col="light blue",
        ylab="Predictive R-squared")
abline(h=max_pr2,col="red", lwd=3)
title = "Predictive R-squared for model 4, 5 and 6 in table 1")
