#PC4: My data has five columns and 100 rows. 
#Since i and j only consist of values of 0 and 1, histograms are not appropriate. 
#Descriptive statistics for x, k, and y should include mean, minimum, maximum, sd and variance. 
#Decriptive stats for k, i, and j could be frequency tables. 
#To get the minimums, quartiles, means, medians and maximums I wrote: 
> summary(week3_dataset_polly):
x                j              i              k       
Min.   :-55.03   Min.   :0.00   Min.   :0.00   Min.   :0.00  
1st Qu.: 20.37   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:1.00  
Median : 43.33   Median :0.00   Median :1.00   Median :1.00  
Mean   : 46.58   Mean   :0.45   Mean   :0.55   Mean   :1.41  
3rd Qu.: 75.02   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:2.00  
Max.   :171.88   Max.   :1.00   Max.   :1.00   Max.   :3.00  
y         
Min.   :-247.2  
1st Qu.: 108.1  
Median : 232.9  
Mean   : 260.0  
3rd Qu.: 383.4  
Max.   : 768.3 
#The following resulted in histograms for x, k and y 
> hist(week3_dataset_polly)
#To get histograms for each, I did the following:
>hist(week3_dataset_polly$x)
> hist(week3_dataset_polly$j)
> hist(week3_dataset_polly$i)
> hist(week3_dataset_polly$k)
> hist(week3_dataset_polly$y)
#To get sd and variance for x and y, I wrote: 
> sd(week3_dataset_polly$x
[1] 43.04128
> sd(week3_dataset_polly$y
[1] 229.5125
> var(week3_dataset_polly$x
[1] 1852.552
> var(week3_dataset_polly$y
[1] 52675.97
#to get frequencies for j, i and k, I did: 
> table(tmp.week3$j)
0  1 
55 45
> table(tmp.week3$i)
0  1 
45 55 
> table(tmp.week3$k)
0  1  2  3 
13 45 30 12

#PC5: Week2 dataset and X of week_03 are identical. See below:
#(Im' using tmp.week3 for my week 3 data). 
> boxplot(tmp.week3$x, week2.dataset)
#also, the functions below reveal two perfectly identical data sets: 
sort(tmp.week3$x)
sort(week2.dataset)

#PC6: To graph all the variables, I first had to recode i and j, so: 
tmp.week3$i<-as.logical(tmp.week3$i)
tmp.week3$j<-as.logical(tmp.week3$j)
#then I made the first plot, so far so good:
> ggplot(data = tmp.week3) + geom_point() +aes(x=x, y=y, color=k)
#But when I did this:
> ggplot(data = tmp.week3) + geom_point() +aes(x=x, y=y, color=k, size=i, shape=j)
#I got this:
Error: A continuous variable can not be mapped to shape
#hmm. Did my class revert? I checked. Lo, it was integer. Made them logical again.
> ggplot(data = tmp.week3) + geom_point() +aes(x=x, y=y, color=k, size=i, shape=j)
#No results in a rather chaotic plot, with the following warning message:
#Warning message:
  #Using size for a discrete variable is not advised.

#PC7: To recode k as a factor: 
tmp.week3$k<-as.factor(tmp.week3$k)
#To change the names of the factors of k to the meanings:
> library(plyr)
revalue(tmp.week3$k, c("0"="none", "1"="some", "2"="lots", "3"="all"))
#However, I wasn't sure how to save that. So I did this: 
> levels(tmp.week3$k)[levels(tmp.week3$k)=="2"] <- "lots"
> levels(tmp.week3$k)[levels(tmp.week3$k)=="3"] <- "all"
> levels(tmp.week3$k)[levels(tmp.week3$k)=="1"] <- "some"
> levels(tmp.week3$k)[levels(tmp.week3$k)=="0"] <- "none"

#PC8:To change all value 0 data in "i" to NA: 
tmp.week3[tmp.week3$i == 0, "i"] <-NA
#To put set them all back to 0:
is.na(tmp.week3$i)
tmp.week3$i[is.na(tmp.week$i)] <- 0

#PC8
#Now that you have recoded your data in PC7, 
#generate new summaries for those three variables.
> summary(tmp.week3$j)
Mode   FALSE    TRUE    NA's 
logical      55      45       0 
> It was summary(tmp.week3$j)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.00    0.00    0.00    0.45    1.00    1.00 
> summary(tmp.week3$i)
   Mode   FALSE    TRUE    NA's 
logical      45      55       0 
> It was:> summary(tmp.week3$i)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.00    0.00    1.00    0.55    1.00    1.00 
> summary(tmp.week3$k)
none some lots  all 
13   45   30   12 
It was: > summary(week3_dataset_polly$k)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.00    1.00    1.00    1.41    2.00    3.00 
#Also, go back and regenerate the visualizations. 
#How have these changed? 
#The boxplots haven't changed
#I don't see significant change in the gg plot, other than there are cool new lables on the 
#plot showing TRUE and FALSE for i and j and named levels for k
#How are these different from the summary detail you presented above?
#Summaries for i, j and k are organized differently, showing frequency tables
#for all three, with k showing new names for the levels. 

