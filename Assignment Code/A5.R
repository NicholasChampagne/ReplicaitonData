rm(list = ls())
if(!is.null(dev.list())) dev.off()
cat("\014") 
pathd <- "D:\\Data File"
pathf <- "D:\\Figures"
setwd(pathd)
library(fmsb)

feadt <- read.csv("feadt.csv", header = TRUE)
feadt$total <- rowSums(feadt[,3:9]) - 45
feadt$Type <- c("Physcial", "Physical", "Hybrid", "Physical", "Physical", "Physical", "Physical", "Physical", "Physical", "Physical", "Physical", "Physical", "Physical", "Hybrid", "Physical", "Hybrid", "Physical", "Physical", "Magic", "Magic", "Hybrid", "Hybrid", "Magic", "Physical", "Physical")
colnames(feadt) <-  c("Name", "HP", "Str", "Mag", "Skl", "Spd", "Lck", "Def", "Res", "Total","Type")

setwd(pathf)
png(filename = "EPPS6356A5F1.png",
    width = 700, height = 700)
par(mar = c(5,6.5,2,2) + .1)
barplot(height = feadt[order(feadt$Total, decreasing = F),10], names = feadt[order(feadt$Total, decreasing = F),1],
        main = "Variable Max Stat Total for all Upgraded Classes",
        horiz = T, xlim = c(min(feadt$Total)-1,max(feadt$Total)), xpd = FALSE, las = 1, xaxp = c(c(min(feadt$Total),max(feadt$Total)),2),
        col = ifelse(feadt[order(feadt$Total, decreasing = F),11] == "Physical", "firebrick",
                     ifelse(feadt[order(feadt$Total, decreasing = F),11] == "Magic", "dodgerblue", "darkorchid4"))
  
)
dev.off()

png(filename = "EPPS6356A5F2.png",
    width = 700, height = 700)
par(mar = c(5,4,4,2) + .1)
Plot <- barplot(height = colMeans(feadt[,3:9]), names = c("Str", "Mag", "Skl", "Spd", "Lck", "Def", "Res"),
        main = "Average Stats",
        ylim = c(0,50), yaxp = c(0,45,3)
)
text(x = Plot, y = colMeans(feadt[,3:9]) + 1, labels = signif(colMeans(feadt[,3:9]), digits = 2))
dev.off()

png(filename = "EPPS6356A5F3.png",
    width = 1000, height = 1000)
par(mfrow = c(5,5), mar = c(1,1,2,1))
for (i in 1:25) {
  radarchart(rbind(rep(50,6), rep(20,6), feadt[i,c(3,4,5,6,8,9)]), axistype = 1,
             title = feadt[i,1], pfcol = rgb(0,.75,1,.5), pcol = rgb(0,.41,.55,1), plwd = 2, cglty = 1,
             seg = 3, caxislabels = seq(20,50,10), axislabcol="black", vlcex = 1.5, cex.main = 1.5, calcex = 1.2
  )
}
dev.off()

png(filename = "EPPS6356A5F4.png",
    width = 700, height = 700)
radarchart(rbind(rep(50,6), rep(20,6), feadt[6,c(3,4,5,6,8,9)], colMeans(feadt[,c(3,4,5,6,8,9)])), axistype = 1,
           title = feadt[6,1], pfcol = c(rgb(0,.75,1,.5), rgb(.8,0,0,.3)), pcol = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), plwd = 2, cglty = 1,
           seg = 3, caxislabels = seq(20,50,10), axislabcol="black", vlcex = 1.5, cex.main = 1.5, calcex = 1.2
)
legend("topright", legend = c("Class", "Average"), col = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), lty = 1:2, cex = 1.5, lwd = 3)
dev.off()

png(filename = "EPPS6356A5F5.png",
    width = 700, height = 700)
radarchart(rbind(rep(50,6), rep(20,6), feadt[4,c(3,4,5,6,8,9)], colMeans(feadt[,c(3,4,5,6,8,9)])), axistype = 1,
           title = feadt[4,1], pfcol = c(rgb(0,.75,1,.5), rgb(.8,0,0,.3)), pcol = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), plwd = 2, cglty = 1,
           seg = 3, caxislabels = seq(20,50,10), axislabcol="black", vlcex = 1.5, cex.main = 1.5, calcex = 1.2
)
legend("topright", legend = c("Class", "Average"), col = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), lty = 1:2, cex = 1.5, lwd = 3)
dev.off()

png(filename = "EPPS6356A5F6.png",
    width = 700, height = 700)
radarchart(rbind(rep(50,6), rep(20,6), feadt[20,c(3,4,5,6,8,9)], colMeans(feadt[,c(3,4,5,6,8,9)])), axistype = 1,
           title = feadt[20,1], pfcol = c(rgb(0,.75,1,.5), rgb(.8,0,0,.3)), pcol = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), plwd = 2, cglty = 1,
           seg = 3, caxislabels = seq(20,50,10), axislabcol="black", vlcex = 1.5, cex.main = 1.5, calcex = 1.2
)
legend("topright", legend = c("Class", "Average"), col = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), lty = 1:2, cex = 1.5, lwd = 3)
dev.off()

png(filename = "EPPS6356A5F7.png",
    width = 700, height = 700)
radarchart(rbind(rep(50,6), rep(20,6), feadt[14,c(3,4,5,6,8,9)], colMeans(feadt[,c(3,4,5,6,8,9)])), axistype = 1,
           title = feadt[14,1], pfcol = c(rgb(0,.75,1,.5), rgb(.8,0,0,.3)), pcol = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), plwd = 2, cglty = 1,
           seg = 3, caxislabels = seq(20,50,10), axislabcol="black", vlcex = 1.5, cex.main = 1.5, calcex = 1.2
)
legend("topright", legend = c("Class", "Average"), col = c(rgb(0,.41,.55,1), rgb(1,0,0,1)), lty = 1:2, cex = 1.5, lwd = 3)
dev.off()