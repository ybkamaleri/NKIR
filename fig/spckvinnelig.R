# Data Kvinnelig inkontinent
# lage Excel data i CSV(semikolondelt) og ikke i CSV(MS-DOS)
rm(list=ls())
data1 <- read.csv("P:\\OUS\\rapdata\\kompcc.csv", header = TRUE, sep = ";", encoding = "latin1")


setwd("~/OUS/regdata")
data1 <- read.csv("kompcc.csv", header = TRUE, sep = ";", encoding = "latin1")
data <- read.csv("kompcc01.csv", header = TRUE, sep = ";", encoding = "utf-8") #ny datasett

data$rek <- 1:nrow(data) #rekkefølge
data$Syk <- factor(data$Syk, levels = data$Syk[rev(data$rek)])

syk = c("AHUS", "Arendal", "Bodø", "Bærum", "Drammen",
        "Elverum", "Førde", "Gjøvik", "Hammerfest", "Haugesund",
        "Haukeland", "Kirkenes", "Kongsberg", "Kristiansand", "Kristiansund",
        "Levanger", "Lillehammer", "Mo i Rana", "Namsos", "Narvik",
        "Ringerike", "Sandessjøen", "Skien", "St Olav", "Stavanger",
        "Stomarknes", "Tromsø", "Ullevål", "Vestfold", "Volda", "Voss",
        "Østfold", "Ålesund")
# uten å behøve å skrive alle
labs <- paste(names(table(data$Syk))) #bare navn
labs2 <- paste(names(table(data1$Sykehus)), "sykehus", sep = " ") #navn med sykehsus


library(qicharts)
x11()

qic(Komp,
    n = Antall,
    x = Sykehus,
    data = data1, 
    chart = 'p', 
    multiply = 100,
    dots.only = TRUE,
    flip = TRUE,
    xlab = "Sykehus",
    ylab = "Prosent")

qic(Komp,
    n = Antall,
    x = Sykehus,
    data = data1,
    chart = 'p',
    multiply = 100,
    dots.only = TRUE,
    xlab = "Sykehus",
    ylab = "Prosent")


dev.off()

#### Figure brukes til NHKiR rapport
##order by percent 
data$pro <- data$Komp/data$Antall*100
data1 <- data[order(data$pro),] #order the data.frame
data1$Sykehus <- factor(data1$Sykehus, levels = data1$Sykehus[order(data1$pro1)]) #order data for plot

tcc(n = Komp,
    d = Antall,
    x = Syk,
    data = data,
    chart = "p",
    multiply = 1,
    dots.only = TRUE,
    flip = TRUE,
    cex = 1.5,
    pex = 2, #dot size
    y.percent = TRUE,
    main = "Personer med komplikasjoner",
    ylab = "Prosent",
    xlab = ""
    )

x11()


# QCC package

library("qcc")
attach(data)
x11()
kvin1 <- qcc(Komp,
    type = "p",
    sizes = Antall,
    labels = lab,
    plot = FALSE)

#par(xaxt = "n") # remove x-label
plot(kvin1)
detach(data)

## try to rotate x lab
attach(data1)
x11()
par(mar = c(7, 4, 2, 2) + 0.2)
#end_point <- 0.5 + nrow(data) + nrow(data)-1
obj <- qcc(Komp,
             type = "p",
             sizes = Antall,
             labels = labs,
             #plot = FALSE,
             axes.las=2, 
             chart.all = TRUE,
             xlab = "",
             ylab = "Prosent",
             title = "Komplikasjoner")

#axes.las=3, #snu label x-aksen perpendicular to axis
#chart.all = TRUE, #snu tall på y-aksen
##par(las=2) # x-label perpendicular to axis
##par(yaxt = "n")
plot(obj)
# text(seq(1.5, end_point, by=2), par("usr")[3]-0.25,
#      srt = 60, adj = 1, xpd = TRUE,
#      labels = paste(labs), cex=0.65)
# axis(2, at=pretty(obj$statistics), lab=paste(pretty(obj$statistics)*100,"%"))

detach(data)
