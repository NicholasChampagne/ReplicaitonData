rm(list = ls())
if(!is.null(dev.list())) dev.off()
cat("\014") 
library(VGAM)

load("crash_base.RData")
crash <- crash[,c(1,2,4:7,9,15:20)]
save(crash, file = "crash.RData")


fit.1 <- vglm(severity ~ Road.Class + Speed.Limit + Weather + Time.of.Day + Type.of.Collision + At.Intersection.Flag, data = crash, family = cumulative(parallel = F ~ Road.Class),
              trace = T)

# Return coefficients explanation below Road.Class City Street and Time.Of.Day Day are base categories
s <- summaryvglm(fit.1); s
# The vglm function uses the stopping ratio method. Essentially we are looking at the odds of the dependent variable
# being lower than a specific category, versus being higher than a specific category.
# As a result, when the Beta coefficient is high in the positive direction, the probability of the dependent variable
# stopping at a category is also higher. When the Beta coefficient is low in the negative direction, the probability 
# of the dependent variable stopping at the category is low.
# When interpreting within the relationship to our variables, since being in a higher category is bad (death is the highest category)
# It is considered 'good' if Beta is high, and 'bad' if Beta is low. 

# Saving the coefficient matrix, but adjusting it to let it be a bit easier to pass on to
# Other funciton by changing the rownames of the matrix into its own column
coeff.matrix <- s@coef3; coeff.matrix
coeff.matrix <- cbind(coeff.matrix,c(rownames(coeff.matrix)))
colnames(coeff.matrix) <- c(colnames(coeff.matrix)[1:4], "Variable")
rownames(coeff.matrix) <- NULL
coeff.matrix <- data.frame(coeff.matrix[,c(5,1:4)])

save(coeff.matrix, file = "Coeff.RData")

load("Coeff.RData")

