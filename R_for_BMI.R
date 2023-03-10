library(ragg)

# set this for making script directory as PATH
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# males chart
stature_m_soph <- read.csv("data/BMI_m_soph_3-17.csv") 

# this line if for scaling the displayed plot. You can play with "scaling"
# if you are not satisfied with the outcome
ragg::agg_jpeg("figures/BMI_chart.jpeg", 
               width = 1080, height = 1080, units = "px", res = 300, scaling = 0.45)

mydataAA=stature_m_soph  

#	Load data
ccF <- read.csv("data/antropometric charts/Yakut males BMI 3 to 17 y.csv")

#	create dataframe for F with numeric
mydataF <- ccF
cols = c(1:ncol(mydataF))
mydataF[,cols] = apply(mydataF[,cols], 2, function(x) as.numeric(as.character(x)))

attach(mydataF)
par(mgp = c(3, 1, 0))
plot(lowess(Agemos, P5, f=.01), type="l", ylim=c(13, 25), xlim=c(36, 204), lty=2, lwd=0, axes=F, xlab = "", ylab = "")
title(main="", ylab="BMI (kg / m²)", xlab="Age (years)")

# y axis left
axis(side=2, at=seq(13, 25, 0.2), labels=FALSE, col.ticks="black")
axis(side=2, at=seq(13, 25, 1), labels=seq(13, 25, 1), lwd.ticks=2)

# y axis right
axis(side=4, at=seq(13, 25, 0.2), labels=FALSE, col.ticks="black")
axis(side=4, at=seq(13, 25, 1), labels=seq(13, 25, 1), lwd.ticks=2)

# x axis down
axis(side=1, at=seq(36, 204, 6), labels=FALSE, col.ticks="black")
axis(side=1, at=seq(36, 204, 12), labels=seq(3, 17, 1), lwd.ticks=2)

lines(lowess(Agemos, P5,  f=.01), lty=2, lwd=1, col = "blue")
lines(lowess(Agemos, P50, f=.01), lty=2, lwd=1, col = "blue")
lines(lowess(Agemos, P95, f=.01), lty=2, lwd=1, col = "blue")

text(max(Agemos)+3, max(P5),  "5th",  adj=0.3, cex=.55)
text(max(Agemos)+3, max(P50), "50th", adj=0.3, cex=.55)
text(max(Agemos)+3, max(P95), "95th", adj=0.3, cex=.55)

detach(mydataF)

lines(lowess(mydataAA$months, mydataAA$length, f=.30), lwd=2, col = "blue")

text(max(mydataAA$months)+1, tail(mydataAA$length, n = 1)+0.7, "SOPH \n M", adj=0.3, cex=.55)

# females chart

stature_f_soph <- read.csv("data/BMI_f_soph_3-17.csv") 
mydataAAf=stature_f_soph  

ccF <- read.csv("data/antropometric charts/Yakut females BMI 3 to 17 y.csv")

#	create dataframe for F with numeric
mydataF <- ccF
cols = c(1:ncol(mydataF))
mydataF[,cols] = apply(mydataF[,cols], 2, function(x) as.numeric(as.character(x)))

attach(mydataF)

lines(lowess(Agemos, P5,  f=.01), lty=2, lwd=1, col = "red")
lines(lowess(Agemos, P50, f=.01), lty=2, lwd=1, col = "red")
lines(lowess(Agemos, P95, f=.01), lty=2, lwd=1, col = "red")

text(max(Agemos)+3, max(P5),  "5th",  adj=0.3, cex=.55)
text(max(Agemos)+3, max(P50), "50th", adj=0.3, cex=.55)
text(max(Agemos)+3, max(P95), "95th", adj=0.3, cex=.55)

detach(mydataF)

lines(lowess(mydataAAf$months, mydataAAf$length, f=.30), lwd=2, col = "red")

text(max(mydataAAf$months)+1, tail(mydataAAf$length, n = 1)-0.5, "SOPH \n F", adj=0.3, cex=.55)

dev.off()

