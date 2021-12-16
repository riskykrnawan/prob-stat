library(GGally)
library(ggplot2)
library(gridExtra)
library(dplyr)
library(scales)
setwd("C:/Users/Lenovo-PC/Documents/akritas_datasets")
DB <- read.table("BearsData.txt", header = TRUE)
attach(DB)

female <- sum(DB$Sex =='F')
male <- sum(DB$Sex =='M')


group <- ifelse( DB$Sex =='F', "Female",
                 ifelse(DB$Sex =='M', "Male",
                        "-"))


df_gender <- data.frame(
  Value=c(female, male),
  Gender = unique(group)
  )
df_age <- data.frame(
  x_age = str_sort(DB$Age, numeric = TRUE))

g1 <- ggplot(data=df_gender, aes(x=Gender, y=Value)) +
  geom_bar(stat="identity", fill="lightblue")+
  geom_text(aes(label=Gender), vjust=1.6, color="white", size=3.5)


g2 <- ggplot(data = subset(df_age, select = c(x_age)), aes(x = x_age)) + 
  geom_histogram(fill="lightblue", stat = "Count")

  
# Head.L Head.W Neck.G Chest.G Weight
g3 <- ggpairs(DB[4:8], aes(colour=DB$Sex))

grid.arrange(g1, g2, nrow = 2)
