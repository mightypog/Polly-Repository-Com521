#PC0. Load up your dataset as you did in Week 3 PC2.
library(readr)
week3_dataset_polly <- read_csv("~/Desktop/uwcom521-assignments/week_03/week3_dataset-polly.csv")
View(week3_dataset_polly)

#PC1. Run a t.test between x and y in the dataset and be ready to interpret the results for the class.
View(week3_dataset_polly)
t.test(week3_dataset_polly$x, week3_dataset_polly$y)
#     Welch Two Sample t-test
#     data:  week3_dataset_polly$x and week3_dataset_polly$y
#     t = -9.1405, df = 105.95, p-value = 4.837e-15
#     alternative hypothesis: true difference in means is not equal to 0
#     95 percent confidence interval:
#     -259.7400 -167.1469
#     sample estimates:
#     mean of x mean of y 
#     46.58402 260.02745 


#PC2. Estimate how correlated x and y are with each other.
cor(week3_dataset_polly$x, week3_dataset_polly$y)
#[1] 0.8408169

#PC3. Recode your data in the way that I laid out in Week 3 PC7.
week3_dataset_polly$i <- as.logical(week3_dataset_polly$i)
week3_dataset_polly$j <- as.logical(week3_dataset_polly$j)
week3_dataset_polly$k.factor <- factor(week3_dataset_polly$k,
                                 levels=c(0,1,2,3),
                                 labels=c("none", "some", "lots", "all"))

# spotcheck to make sure it looks good
head(week3_dataset_polly, 10)

week3_dataset_polly$k <- week3_dataset_polly$k.factor
week3_dataset_polly$k <- NULL #delete the old one

w3x <- week3_dataset_polly$x
w3y <- week3_dataset_polly$y
w3i <- week3_dataset_polly$i
w3k <- week3_dataset_polly$k.factor
w3j <- week3_dataset_polly$j

#PC4. Generate a set of three linear models and be ready to intrepret the coefficients, standard errors, 
#t-statistics, p-values, and R^2 for each

#A
lm(x ~ y, data = week3_dataset_polly)
#   Coefficients:
#     (Intercept)            y  
#         5.5825          0.1577 
summary(lm(x ~ y, data = week3_dataset_polly))
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-68.393 -17.557   0.873  15.131  62.152 
#Coefficients:
#             Estimate Std. Error  t value Pr(>|t|)    
#(Intercept)  5.58254    3.54880   1.573    0.119    
#y            0.15768    0.01025  15.377   <2e-16 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#Residual standard error: 23.42 on 98 degrees of freedom
#Multiple R-squared:  0.707,	Adjusted R-squared:  0.704 

#B
lm(formula = x ~ y + w3i + w3j, data = week3_dataset_polly)
summary (lm (x ~ y + w3i + w3j, data = week3_dataset_polly))
#Call:
#  lm(formula = x ~ y + w3i + w3j, data = week3_dataset_polly)
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-66.837 -14.692  -0.856  16.564  59.323 
#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  12.61588    4.27802   2.949   0.0040 ** 
#  y             0.16767    0.01049  15.991   <2e-16 ***
#  w3iTRUE      -7.87344    4.57233  -1.722   0.0883 .  
#w3jTRUE     -11.77827    4.79025  -2.459   0.0157 *  
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#Residual standard error: 22.61 on 96 degrees of freedom
#Multiple R-squared:  0.7325,	Adjusted R-squared:  0.7241 
#F-statistic: 87.62 on 3 and 96 DF,  p-value: < 2.2e-16

#C
lm (x ~ y + w3i + w3j +w3k, data = week3_dataset_polly)
summary(lm (x ~ y + w3i + w3j +w3k, data = week3_dataset_polly))
#Call:
#  lm(formula = x ~ y + w3i + w3j + w3k, data = week3_dataset_polly)
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-63.018 -15.643  -0.428  15.700  56.720 
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  23.37545    7.83202   2.985  0.00363 ** 
#  y             0.16587    0.01042  15.917  < 2e-16 ***
#  w3iTRUE      -8.59972    4.62249  -1.860  0.06599 .  
#w3jTRUE     -11.62518    4.77873  -2.433  0.01690 *  
#  w3ksome     -14.15715    7.12834  -1.986  0.04997 *  
#  w3klots      -6.77023    7.59103  -0.892  0.37476    
#w3kall      -12.99651    9.15342  -1.420  0.15899    
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#Residual standard error: 22.38 on 93 degrees of freedom
#Multiple R-squared:  0.7459,	Adjusted R-squared:  0.7295 
#F-statistic: 45.51 on 6 and 93 DF,  p-value: < 2.2e-16

#PC5. Generate a set of residual plots for the final model (c) and be ready to interpret your model in terms of each of these:
#(a) A histogram of the residuals.
hist(residuals(lm (x ~ y + w3i + w3j +w3k, data = week3_dataset_polly)))

#(b) Plot the residuals by your values of x, i, j, and k (four different plots).
plot(residuals(lm (y~ x, data = week3_dataset_polly)))
plot(residuals(lm (y~ w3i, data = week3_dataset_polly)))
plot(residuals(lm (y~ w3j, data = week3_dataset_polly)))
plot(residuals(lm (y~ w3k, data = week3_dataset_polly)))

#(c) A QQ plot to evaluate the normality of residuals assumption.
library(ggplot2)
qqnorm(residuals(lm (x ~ y + w3i + w3j +w3k, data = week3_dataset_polly)))

#PC6. Generate a nice looking publication-ready table with a series of fitted models and put them in a Word document.
w3 <- (lm (x ~ y + w3i + w3j +w3k, data = week3_dataset_polly))
install.packages("stargazer")
+stargazer(w3, type = "text")

#PC7. Load up the dataset once again and fit the following linear models and be ready to interpret them similar to the way you did above in PC4:
#(a)
H < - Halloween2012_2014_2015_PLOS
fruit <- H$fruit
michelle <- H$obama
fm <- lm(fruit~michelle, data = H)
summary(fm)
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-0.2748 -0.2748 -0.2378  0.7252  0.7622 
#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  0.23779    0.01555  15.293   <2e-16 ***
#  michelle     0.03699    0.02580   1.434    0.152    
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#Residual standard error: 0.4337 on 1220 degrees of freedom
#(1 observation deleted due to missingness)
#Multiple R-squared:  0.001682,	Adjusted R-squared:  0.0008639 
#F-statistic: 2.056 on 1 and 1220 DF,  p-value: 0.1519

#(b)Add a control for age and a categorical version of a control for year to the model in (a).
as.factor(H$year)
new.fm <-lm(fruit~michelle + H$year + H$age, data = H)
summary(new.fm)
#Call:
#  lm(formula = fruit ~ michelle + H$year + H$age, data = H)
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-0.3079 -0.2562 -0.2373  0.6929  0.8174 
#Coefficients:
# Estimate Std. Error t value Pr(>|t|)  
#(Intercept) -41.223494  25.621354  -1.609   0.1079  
#michelle      0.044989   0.026256   1.713   0.0869 .
#H$year        0.020575   0.012721   1.617   0.1060  
#H$age         0.001694   0.004038   0.420   0.6749  
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#Residual standard error: 0.4335 on 1218 degrees of freedom
#(1 observation deleted due to missingness)
#Multiple R-squared:  0.004089,	Adjusted R-squared:  0.001636 
#F-statistic: 1.667 on 3 and 1218 DF,  p-value: 0.1723

#PC8. Take a look at the residuals for your model in (a) and try to interpret these as you would in PC4 above. What do you notice?
qqnorm(residuals(new.fm))
#This looks bizarre to me. I have no idea how to interpret this.
plot(residuals(lm(fruit~michelle, data = H)))
#Even weirder
plot(residuals(lm(H$year~H$age, data = H)))
#DEK

#PC9. Run the simple model in (a) three times on three subsets of the dataset: 
#just 2012, 2014, and 2015. Be ready to talk through the results.
y2012 <- subset(H, year == 2012)
y2014 <- subset(H, year == 2014)
y2015 <- subset(H, year == 2015)
test.2012<- lm(y2012$fruit ~ y2012$obama, data = y2012)
test.2014<- lm(y2014$fruit ~ y2014$obama, data = y2014)
test.2015<- lm(y2015$fruit ~ y2015$obama, data = y2015)
summary(test.2012)
summary(test.2014)
summary(test.2015)
