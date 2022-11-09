rm(list = ls())
if(!is.null(dev.list())) dev.off()
cat("\014") 
library(VGAM)
pathd <- "D:\\School\\Data Visualization\\Project"
pathf <- "D:\\School\\Figures"
setwd(pathd)

load("crash_model.RData")

fit.test1 <- vglm(severity ~ Road.Class + Speed.Limit + Weather + Time.of.Day + Type.of.Collision + At.Intersection.Flag, data = crash, family = cumulative(parallel = F ~ Road.Class))

# Return coefficients explanation below Road.Class City Street and Time.Of.Day Day are base categories
summary(fit.test1)
# The vglm function uses the stopping ratio method. Essentially we are looking at the odds of the dependent variable
# being lower than a specific category, versus being higher than a specific category.
# As a result, when the Beta coefficient is high in the positive direction, the probability of the dependent variable
# stopping at a category is also higher. When the Beta coefficient is low in the negative direction, the probability 
# of the dependent variable stopping at the category is low.
# When interpreting within the relationship to our variables, since being in a higher category is bad (death is the highest category)
# It is considered 'good' if Beta is high, and 'bad' if Beta is low. 