 library(readr)
COS_Statistics_Top5000_Pages <- read_csv("~/Desktop/Winter 2017/Com 521/Polly-Repository-Com521/COS-Statistics-Top5000-Pages.csv")
View(COS_Statistics_Top5000_Pages)

View(COS_Statistics_Mobile_Sessions<- read_csv("~/Desktop/Winter 2017/Com 521/Polly-Repository-Com521/COS_Statistics_Mobile_Sessions.csv")
     View
#These are the two datasets, in case I need to relaod. 
#To explore the data, I did:
> nrow(mobile.sessions)
> ncol(mobile.sessions)
> head(mobile.sessions)
> lapply(mobile.sessions, class)
> lapply(mobile.sessions, summary)
> table(mobile.sessions$Operating_System) 
> sample(mobile.sessions$Operating_System, 10)
colnames(mobile.sessions)
sample(mobile.sessions$New_Sessions, 10)
> sample(mobile.sessions$Bounce_Rate, 10)

#PC3: Attempt 1
data.frame(nm1=top.5000$Month, nm2=top.5000$Pageviews)
month.views<- data.frame(nm1=top.5000$Month, nm2=top.5000$Pageviews)
#Fail
#PC3 Attempt 2, from Mako.Help
#Step 1, make a table that adds up all the page views by month

> total.views.bymonth.tbl <- tapply(top.5000$Pageviews, top.5000$Month, sum)

#Now to turn it into a data frame: 

> total.views <- data.frame(months=names(total.views.bymonth.tbl), 
                            total=total.views.bymonth.tbl)

#That worked. Here's the head: 
months     total
1/1/15 0:00   1/1/15 0:00   6360162
1/1/16 0:00   1/1/16 0:00 652257537
10/1/15 0:00 10/1/15 0:00   4118869
12/1/15 0:00 12/1/15 0:00   5793270
2/1/15 0:00   2/1/15 0:00   5751804
3/1/15 0:00   3/1/15 0:00   6518290
4/1/15 0:00   4/1/15 0:00   6416887

#But lo, that is ugly. Fortunately you can make it less ugly by getting 
#     rid of the row names: 

> row.names(total.views) <- NULL

#choir of angels: 

head(total.views)

        months     total
1  1/1/15 0:00   6360162
2  1/1/16 0:00 652257537
3 10/1/15 0:00   4118869
4 12/1/15 0:00   5793270
5  2/1/15 0:00   5751804
6  3/1/15 0:00   6518290

#Most excellent. On to PC4. 

#Using the mobile dataset, create a new data frame where one column is each month described in the data
#and the second is a measure (estimate?) of the total number of views made by mobiles (all platforms) 
#over each month. This will will involve at least two steps since total views are included. 
#You'll need to first use the data there to create a measure of the total views per platform.
  
#Step 1: Get a column together that has the total page views, yielded by the product 
#   of Sessions and PagesPerSession.  
# I'll make a column called total.views like this: 

> mobile.sessions$total.views <-mobile.sessions$Sessions * mobile.sessions$PagesPerSession

head(mobile.sessions) #shows a new column now called total.views. Awesome. 

#Step 2: Basically do the same thing with tapply, to get the sum of total.views by month: 

> mobile.views.bymonth.tbl <- tapply(mobile.sessions$total.views, mobile.sessions$Month, sum) 
> head(mobile.views.bymonth.tbl)

#Cool. I now have a table called mobile.views.bymonth.tbl. I want to make it into a dataframe: 

> mobile.views.bymonth.tbl <- tapply(mobile.sessions$total.views, mobile.sessions$Month, sum) 
> head(mobile.views.bymonth.tbl)

#And I want to get rid of the row names again: 

> row.names(mobile.views)=NULL

#Behold this thing of beauty! 

> head(mobile.views)
        months     total
1  1/1/15 0:00 1399185.6
2  1/1/16 0:00  668275.2
3 10/1/15 0:00 1285288.0
4 12/1/15 0:00 1223414.0
5  2/1/15 0:00 1275315.2
6  2/1/16 0:00  592607.8

#On to PC5! 


#Merge your two datasets together into a new dataset with columns for each month, 
#total views (across the top 5000 pages) and total mobile views. 
#Are there are missing data? Can you tell why?

#Step 1. I am already keenly aware from earlier experiments that the dates in my total.views dataframe is not in date format. 

class(mobile.views$months) #reveals that they are in factor format
[1] "factor"

#I try this: 

> as.Date(mobile.views$months, format = "%Y-%m-%d")
#And get this:
[1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA

#I review the way the dates look in my data frame, notice the months are first, and try this: 

> as.Date(mobile.views$months, format = "%m-%d-%Y")

and get: 
  
  [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA

#Augh. I try: 

> mobile.views$months <- as.Date(mobile.views$months)

#Ding ding ding! 

> class(mobile.views$months)
[1] "Date"

#Now to merget the dataframes mobile.views and total.views

#Helpless as a baby giraffe, I spy to see what Anissa the Clever did. 
#Adapting what she did to my data frames, I write: 

merged.data.frames <- merge(mobile.views, top.5000, by.x="Month", by.y = "Month", all.x = TRUE, all.y = TRUE)

#And I get: 
m
Error in fix.by(by.x, x) : 'by' must specify a uniquely valid column

#For fun, I try: 

> merge(mobile.views, total.views)

# Hmmmm. That wasn't very fun. I get: 
[1] months total 
<0 rows> (or 0-length row.names)

#Now I try the .x, .y thing, using by month. I"m going to name my merged data merged.data

merged.data <- merge(mobile.views, total.views, by.x = months, by.y = months)

#I get: 
Error in as.vector(x, mode) : 
  cannot coerce type 'closure' to vector of type 'any'
#Dang. Turns out that datas are still factors in total.views. I address that. No joy:

> merged.data <- merge(mobile.views, total.views, by.x = months, by.y = months)
Error in as.vector(x, mode) : 
  cannot coerce type 'closure' to vector of type 'any'

#I google the error message. It seems that adding quotes might help: 

> merged.data <- merge(mobile.views, total.views, by.x="months", by.y = "months")

#Hot damn: 

> head(merged.data)
      months   total.x   total.y
1 0001-01-15 1399185.6   6360162
2 0001-01-16  668275.2 652257537
3 0002-01-15 1275315.2   5751804
4 0003-01-15 1402086.4   6518290
5 0004-01-15 1381295.1   6416887
6 0005-01-15 1605914.9   6544526

#On to PC6

#PC6. Create a new column in your merged dataset that describes your best estimate 
#of the proportion (or percentage, if you really must!) of views that comes from mobile. 
#Be able to talk about the assumptions you've made here. 
#Make sure that date, in this final column, is a date or datetime object in R.

#It seems that I need to run another tapply, with the function being divide, the thing being 
#divided total.x (mobile views), and the divisor total.y, (total views). 

#First I make the column

merged.data$proportion <-merged.data$total.y /merged.data$total.x

#I get: 

> head(merged.data)
    
            months   total.x   total.y  proportion
      1 0001-01-15 1399185.6   6360162 0.219992124
      2 0001-01-16  668275.2 652257537 0.001024557
      3 0002-01-15 1275315.2   5751804 0.221724388
      4 0003-01-15 1402086.4   6518290 0.215100336
      5 0004-01-15 1381295.1   6416887 0.215259384
      6 0005-01-15 1605914.9   6544526 0.245382912

#Now I'm going to round those to two decimal places: 
      
            months   total.x   total.y proportion
      1 0001-01-15 1399185.6   6360162       0.22
      2 0001-01-16  668275.2 652257537       0.00
      3 0002-01-15 1275315.2   5751804       0.22
      4 0003-01-15 1402086.4   6518290       0.22
      5 0004-01-15 1381295.1   6416887       0.22
      6 0005-01-15 1605914.9   6544526       0.25
      
#Clearly there is a problem with row 2. 
# I go back and add the arguments all.x= TRUE and all.y=TRUE. I get a much different outcome. 

            months   total.x   total.y proportion
      1 0001-01-15 1399185.6   6360162       0.22
      2 0001-01-16  668275.2 652257537       0.00
      3 0002-01-15 1275315.2   5751804       0.22
      4 0002-01-16  592607.8        NA         NA
      5 0003-01-15 1402086.4   6518290       0.22
      6 0003-01-16  800842.8        NA         NA
>#Now to plot: 
ggplot(data=merged.data) + geom_point() + aes(x=merged.data$months, y=merged.data$proportion)
      
#This is butt ugly. The month axis is not appearing as months. Grr. I am now out of time. 