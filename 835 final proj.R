#Loading Packages
library(dplyr);library(car);library(leaps);library(MASS);library(bestglm);library(pROC);library(ggplot2)
##################
#Data exploration
data<-read.csv("~/Documents/Masters/Stat 835/Final Proj/healthcare-dataset-stroke-data.csv")
nrow(data)#5110
nrow(subset(data, bmi == 'N/A'))#201 N/A values
nrow(subset(data, smoking_status == 'Unknown'))#1544 Unkown smoking status
#Removing unneeded variables
data<-subset (data ,gender != 'Other')#1 Other variable
data<-subset(data, smoking_status != 'Unknown')
data<-subset(data,select=c(gender, age, hypertension, heart_disease, avg_glucose_level, smoking_status,stroke))
is.na(data)#no missing values
nrow(data)#3565
################
#Purposeful Selection
#Null model
null<-glm(stroke~1, family=binomial, data=data); summary(null)
data %>% ggplot(aes(x=stroke)) + geom_bar() + ggtitle('(e) Bar chart for Stroke') + ylab('')
#Gender only model
g.m<-glm(stroke~gender, family=binomial, data=data); summary(g.m)
anova(null, g.m, test = 'LRT')
data %>% ggplot(aes(x=gender)) + geom_bar() + ggtitle('(a) Bar chart for Gender') + ylab('')
#Age only model
a.m<-glm(stroke~age, family=binomial, data=data); summary(a.m)
anova(null, a.m, test = 'LRT')#significant/lowest AIC of  1298.1
boxplot(data$age, horizontal =TRUE,main = '(a) Box plot of Age')
#Hypertension only model
h.m<-glm(stroke~hypertension, family=binomial, data=data); summary(h.m)
anova(null, h.m, test = 'LRT')#significant/AIC of 1506.3
data %>% ggplot(aes(x=hypertension)) + geom_bar() + ggtitle('(b) Bar chart for Hypertension') + ylab('')
#Heart disease only model
hd.m<-glm(stroke~heart_disease, family=binomial, data=data); summary(hd.m)
anova(null, hd.m, test = 'LRT')#significant/AIC of 1514.8
data %>% ggplot(aes(x=heart_disease)) + geom_bar() + ggtitle('(c) Bar chart for Heart Disease') + ylab('')
#Avg. glucose level only model
ag.m<-glm(stroke~avg_glucose_level, family=binomial, data=data); summary(ag.m)
anova(null, ag.m, test = 'LRT')#significant/AIC of 1506.3
boxplot(data$avg_glucose_level, horizontal =TRUE,main = '(b) Box plot of Avg. Glucose Level')
#Smoking Status
ss.m<-glm(stroke~smoking_status, family=binomial, data=data); summary(ss.m)
anova(null, ss.m, test = 'LRT')#significant/AIC of 1547.3
data %>% ggplot(aes(x=smoking_status)) + geom_bar() + ggtitle('(d) Bar chart for Smoking Status') + ylab('')
#Model w/: age, hypertension, heart disease, avg. glucose, smoking status
m1<-glm(stroke~age+hypertension+heart_disease+avg_glucose_level+smoking_status,family=binomial,data=data); summary(m1)
anova(a.m, m1,test='LRT');anova(h.m, m1,test='LRT');anova(hd.m, m1,test='LRT')
anova(ag.m, m1,test='LRT');anova(ss.m, m1,test='LRT')
#model was more appropriate than single variable models
#full
full.m<-glm(stroke~gender+age+hypertension+heart_disease+avg_glucose_level+smoking_status,family=binomial,data=data); summary(full.m)
anova(m1, full.m, test='LRT')#m1 is more appropriate than the full
#Using AIC for model selection
stepAIC(full.m)
test.m <- glm(stroke ~ age + hypertension + heart_disease + avg_glucose_level,family = binomial, data = data); summary(test.m)
anova(test.m,full.m, test='LRT')#test.m is more appropriate than the full
anova(test.m,m1, test='LRT')#test.m is more appropriate than m1
#testing interaction terms for test.m terms
#Number of 2-way interactions
choose(4,2)
#Number of 3-way interactions
choose(4,3)
#1 4-way interaction
full.sat.m<-glm(formula = stroke ~ age * hypertension * heart_disease * avg_glucose_level,family=binomial,data=data)
summary(full.sat.m)
anova(test.m,full.sat.m, test = 'LRT')
#ROC Curve 4.6.2
rocplot<-roc(stroke~fitted(test.m), data=data)
plot.roc(rocplot, legacy.axes = TRUE)
auc(rocplot)
#R and R^2
cor(data$stroke, fitted(test.m)) # 0.2986627
summary(test.m)
1 - (1271.2/1552.1)#adj. R^2: 0.1809806
#multicolinearity
#Temp. modifying data so correlation table can be made. THIS IS ONLY FOR THE COR TABLE
data$gender <- ifelse(data$gender == "Male", 1, 0)
data$smoking_status <- ifelse(data$smoking_status == "never smoked", 0, ifelse(data$smoking_status == "formerly smoked", 1, 2))
cor(data); vif(test.m)
#prediction classification table
prop<-sum(data$stroke)/nrow(data); prop #proportion of 1's for stoke: 0.05666199
predicted <- as.numeric(fitted(test.m)>prop); predicted
xtabs(~data$stroke + predicted)
sensitivity <- 159/(159+43); sensitivity
specificity <- 2424/(2424+939); specificity
prop.cor <-(159+2424)/(2424+939+43+159); prop.cor

