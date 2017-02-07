#PC1: Load the data into R 

library(readxl)
Red_Dye_Data <- read_excel("~/Desktop/Winter 2017/Com 521/Materials/Red Dye Data.xlsx")

#reshape the dataset 

as.data.frame(Red_Dye_Data)
colnames(Red_Dye_Data) [1] <- "none"
colnames(Red_Dye_Data) [2] <- "low"
colnames(Red_Dye_Data) [3] <- "med"
colnames(Red_Dye_Data) [4] <- "high"

none <- Red_Dye_Data$none
low <- Red_Dye_Data$low
med <- Red_Dye_Data$med
high <- Red_Dye_Data$high

none.factor <- rep("none", length(Red_Dye_Data$none))
none.df <- data.frame(Survival = none, Group = none.factor)

low.factor <- rep("low", length(Red_Dye_Data$low))
low.df <- data.frame(Survival = low, Group = low.factor)

med.factor <- rep("med", length(Red_Dye_Data$med))
med.df <- data.frame(Survival = med, Group = med.factor)

high.factor <- rep("high", length(Red_Dye_Data$high))
high.df <- data.frame(Survival = high, Group = high.factor)

two.col.dye.df<- rbind(none.df, low.df, med.df, high.df)

#PC2 Create summary statistics and visualizations for each group
summary(two.col.dye.df$Survival)
summary(two.col.dye.df$Group)
hist(two.col.dye.df$Survival) #not normal
boxplot(Red_Dye_Data)
tapply(two.col.dye.df$Survival, two.col.dye.df$Group, summary)

#What is the global mean of your dependent variable?
mean(two.col.dye.df$Survival, na.rm = TRUE)

#PC3 Do a t-test between mice with any RD40 and mice with at least a small amount.
any.dye <- c(Red_Dye_Data$low, Red_Dye_Data$med, Red_Dye_Data$high)
t.test(any.dye, Red_Dye_Data$low, na.rm = TRUE)

#Run a t-test between the group with a high dosage and control group. 
t.test(Red_Dye_Data$high, Red_Dye_Data$none, na.rm = TRUE)

#How would you go about doing it using formula notation?
#I dont' know

#PC4: Estimate an ANOVA analysis using aov() to see if there is a difference between the groups. 
my.aov <-aov(two.col.dye.df$Survival ~ two.col.dye.df$Group, data=two.col.dye.df)
summary(my.aov)aov(two.col.dye.df$Survival ~ two.col.dye.df$Group, data=two.col.dye.df)
#The p value is less than .05, therefor the difference between the groups is significant. 

