## SPC
rm(list = ls())

library(qicharts)

############
## DATA
############
filDir <- getwd()
sr01 <- paste0(filDir,"/", "datakilder1.R")
sr02 <- paste0(filDir, "/", "datakilder2.R")
##ifelse(file.exists(sr01), source(sr01), source(sr02))
data <- ifelse(file.exists(sr01), sr01, sr02)
source(data)

## lage prosent
data$per <- round(data$V2 / data$V3 * 100, 2)
bulkdata$per <- round(bulkdata$V2 / bulkdata$V3 * 100, 2)

data$V1 <- factor(data$V1, levels = data$V1[order(-data$V3)])

tcc(n = V2,
    d = V3,
    x = V1,
    data = data,
    chart = "p",
    multiply = 1,
    dots.only = TRUE,
    flip = TRUE,
    cex = 1.5,
    pex = 2, #dot size
    y.percent = TRUE,
    main = "Andel reoperasjoner",
    ylab = "Prosent",
    xlab = ""
    )


## fig02
bulkdata$V1 <- factor(bulkdata$V1, levels = bulkdata$V1[order(-bulkdata$V3)]) #descending order

p <- tcc(n = V3,
         d = V2,
         x = V1,
         data = bulkdata,
         chart = "p",
         multiply = 1,
         dots.only = TRUE,
         flip = TRUE,
         cex = 1.5,
         pex = 2, #dot size
         y.percent = TRUE,
         main = "Andel reoperasjoner Bulkamid",
         ylab = "Prosent",
         xlab = ""
         )

savePlot("fig02", )

############
## Function

ucl <- function(data, tot, def, prot) {
  library(data.table)
  setDT(data)
  tot = data[, sum(get(tot))]
  def = data[, sum(get(def))]
  prot = tot / def

}

setDT(data)
tot <- data[, sum(V3)]
def <- data[, sum(V2)]
prot <- def / tot

sq1 <- sqrt(prot * (1 - prot) / 47)
sq2 <- (prot + 3) * sqrt(prot * (1 - prot) / 47)

test1 <- prot * (1 - prot)
test2 <- test1 / 47
test3 <- sqrt(test2)
sq3 <- (prot + 3) * test3
