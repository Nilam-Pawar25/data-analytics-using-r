#Regression
#getwd()
df <- read.csv("F:/SkillEdge/Analytics_R/Data/Stud_Reg_1.csv", header = T)
View(df)
df

#Single Linear Regression----
result<-lm(APPLICANTS~PLACE_RATE, data=df)
summary(result)
data_fitted<-data.frame(df,fitted.values=fitted(result), residual=resid(result))
data_fitted

df <- read.csv("F:/SkillEdge/Analytics_R/Data/Stud_Reg.csv", header = T)
View(df)

#Multiple Regression----
result<-lm(APPLICANTS~PLACE_RATE+NO_GRAD_STUD, data=df)
summary(result)
data_fitted<-data.frame(df,fitted.values=fitted(result), residual=resid(result))
data_fitted

#Exercise
age<-c(18:29)
age
height<-c(76.1,77,78.1,78.2,78.8,79.7,79.9,81.1,81.2,81.8,82.8,83.5)
height
df<-data.frame(age,height)
df
plot(age~height)
result<-lm(age~height)
summary(result)

#Eq: Age= -100.84 + 1.55*Height

#Accuracy:
#Since R2 is close to 1, hence model is highly significant.

data_fitted<-data.frame(df , fitted.value=fitted(result),residual=resid(result))
data_fitted
library("ggplot2")
g <- ggplot(df, aes(x=height, y=age)) + geom_point() + geom_smooth(method="lm") 
plot(g)

#Exercise2:
names(mtcars)
View(mtcars)
plot(mpg~hp, data=mtcars)
plot(mpg~wt, data=mtcars)
result<-lm(mpg~hp+wt, data=mtcars)
summary(result)

#Value of Adjusted R2 = 0.82, 
#means that "82% of the variance in the measure of mpg can be predicted by hp and wt."

#Checking Multicollinearity:
result<-lm(mpg~hp+wt+disp+cyl+gear, data=mtcars)
summary(result)

#install.packages("usdm")
library(usdm)
vif(mtcars)
vif(mtcars[,c(-3)])
vif(mtcars[,c(-3,-2)])
result<-lm(mpg~hp+wt, data=mtcars)
summary(result)

#----Example-3
#Create Training and Test data ----
trainingRowIndex <- sample(1:nrow(mtcars), 0.8*nrow(mtcars))  # row indices for training data
trainingData <- mtcars[trainingRowIndex, ]  # model training data
testData  <- mtcars[-trainingRowIndex, ]   # test data

#Bi-variate Analysis:----
#Checking relationships between different variables
pairs(mtcars)

#Correlation
cr = cor(mtcars)
cr
library(corrplot)
corrplot(cr,type="lower",method="circle")
corrplot(cr,type="lower",method="number")

#Build the model on training data----

lmMod <- lm(mpg ~ #cyl
              +wt#+disp #+hp
            #+drat+qsec#+vs
            +am#+gear
            +carb, 
            data=trainingData)  # build the model
# Review diagnostic measures
summary (lmMod)  # model summary

#Accuracy:
#Since R2 is close to 1, i.e., 0.84, hence model is significant.

#Prediction----
#Predicitng values for test dataset
testData$mpgPred <- predict(lmMod, testData)
View(testData)
#Accuracy:----
#Determining Prediction accuracy on test dataset using MAPE

#MAPE(MeanAbsolutePercentageError): 
#Lower its value better is the accuracy of the model.
#MAPE Calculation:
mape <- mean(abs((testData$mpgPred - testData$mpg))/testData$mpg)
mape

# Mape using mape function
#install.packages("Metrics")
library(Metrics)
mape(testData$mpgPred,testData$mpg)
