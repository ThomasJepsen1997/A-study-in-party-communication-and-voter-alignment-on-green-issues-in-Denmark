#Sensitivity to Unobserved Confounding: sensemakr

library(sensemakr)



# runs sensemakr for sensitivity analysis


darfur.sensitivity <- sensemakr(model = m3_miljoe, 
                                treatment = "theta_score",
                                benchmark_covariates = "mean_Age",
                                kd = 1:6, reduce = T)

plot(darfur.sensitivity, ylim=c(0,1.1))

plot(darfur.sensitivity, sensitivity.of = "t-value" )

plot(darfur.sensitivity, type = "contour")

ovb_minimal_reporting(darfur.sensitivity, format = "html")
summary(darfur.sensitivity)

sensitivity.1



