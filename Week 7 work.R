library(haven)
lilypad_anonymized_2_ <- read_dta("~/Desktop/lilypad_anonymized (2).dta")
View(lilypad_anonymized_2_)

lpad <-lilypad_anonymized_2_
sales_by_gender <- table(lpad$gender, lpad$order_type)
colnames(sales_by_gender)<- c("Arduino", "Both", "Lilypad")
row.names(sales_by_gender)<- c("Female", "Male", "Unknown")
view(lpad)

lpadUS <- subset(lpad, country == 81)
sales_by_genderUS <- table(lpadUS$gender, lpadUS$order_type)

colnames(sales_by_genderUS)<- c("Arduino", "Both", "Lilypad")
row.names(sales_by_genderUS)<- c("Female", "Male", "Unknown")

chisq.test(sales_by_gender)
#	  Pearson's Chi-squared test
#   data:  sales_by_gender
#   X-squared = 644.3, df = 4, p-value < 2.2e-16

chisq.test(sales_by_genderUS)
#	  Pearson's Chi-squared test
#   data:  sales_by_genderUS
#   X-squared = 567.32, df = 4, p-value < 2.2e-16

install.packages("gmodels")
library("gmodels", lib.loc="/Library/Frameworks/R.framework/Versions/3.3/Resources/library")

CrossTable(sales_by_gender)
CrossTable(sales_by_genderUS)

write.table(sales_by_gender, file = "SBGtable.txt", quote=T, sep= ",")
#Find SBGtable.txt in the working directory
    #copy and paste into Word, 
    #select the text you just pasted from the .txt file
    #go to Table → Convert → Convert Text to Table…
    #make sure “Commas” is selected under “Separate text at”, click OK

mako.vs.tommy <-rbind(c(42, 31),
                      c(19, 14))
row.names(mako.vs.tommy) <-c("mako", "tommy")
colnames(mako.vs.tommy)<-c("Day 1", "Day 2")

prop.test(mako.vs.tommy)

install.packages("readstata13")
library("readstata13", lib.loc="/Library/Frameworks/R.framework/Versions/3.3/Resources/library")
library(haven)

Halloween2012_2014_2015_PLOS <- read_dta("~/Downloads/Halloween Dataverse Files/Halloween2012-2014-2015_PLOS.dta")
View(Halloween2012_2014_2015_PLOS)       