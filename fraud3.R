

#########################TASK1 ###########################################

library(data.table)
library(caret)
library(ggplot2)
library(DMwR)
library(ROSE)
library(e1071)
library(ROSE)


creditcard <- fread("C:/Users/manch/Desktop/Fraud detection/creditcardfraud/creditcard.csv")
str(creditcard)
creditcard$Class <- factor(creditcard$Class, levels = c("1", "0"), labels = c("Yes", "No"))
creditcard <- creditcard[sample(nrow(creditcard)),]
# set.seed(100)
# newdata <- creditcard[creditcard$Class=="No",]
# creditdata <- creditcard[creditcard$Class=="Yes",]
# mysample <- newdata[sample(1:nrow(newdata),10000 ,replace=FALSE),]
# final_data <- rbind(creditdata,mysample)
table(creditcard$Class)
prop.table(table(creditcard$Class))
ggplot(creditcard,aes(x = creditcard$Class, fill="red")) + 
    geom_bar(position = "dodge", alpha = 0.5, col ="black") +
    scale_x_discrete( name = "Is it Fraud?") +
    scale_y_continuous() + 
    ggtitle("Fraud Case Classes") +
    theme(plot.title = element_text(hjust = 0.5))

#########################TASK2###########################################

trainIndex <- createDataPartition(creditcard$Class, p = .7, 
                                  list = FALSE, 
                                  times = 1)
trainSplit <- creditcard[trainIndex,]
# trainSplit$ClassNum <- ifelse(trainSplit$Class=="Yes",1,0)
testSplit <- creditcard[-trainIndex,]
table(trainSplit$Class)
table(testSplit$Class)

set.seed(4356)
smote_data <- SMOTE(Class ~ ., data  = creditcard, perc.over = 300, perc.under = 150, k=5)
ggplot(smote_train,aes(x = smote_train$Class, fill="red")) + 
  geom_bar(position = "dodge", alpha = 0.5, col ="black") +
  scale_x_discrete( name = "Is it Fraud?") +
  scale_y_continuous() + 
  ggtitle("Fraud Case Classes") +
  theme(plot.title = element_text(hjust = 0.5))
new.data <- sample(2, nrow(smote_data), replace = TRUE, prob = c(0.8, 0.2))

trainSplit2 <-smote_data[new.data==1,]
testSplit2 <-smote_data[new.data==2,]
table(trainSplit2$Class)
table(testSplit2$Class)

# Build Decision tree on basic dataset

t.control <- trainControl(
  method = "cv", 
  number = 10, 
  savePredictions = TRUE)

cv.tree <- train(Class ~ ., data = trainSplit, 
                 trControl = t.control, 
                 method = "rpart", 
                 tuneLength=5)
summary(cv.tree)
cv.tree.pred <- predict(cv.tree, testSplit)
confusionMatrix(cv.tree.pred, testSplit$Class)
roc.curve(cv.tree.pred, testSplit$Class, plotit = T)
#AUC:0.936
#Sensitivity:0.748
#Specificty:0.999

# Build Decision tree model on SMOTE dataset

t.control <- trainControl(
  method = "cv", 
  number = 10, 
  savePredictions = TRUE)

cv.tree1 <- train(Class ~ ., data = trainSplit2, 
                  trControl = t.control, 
                  method = "rpart", 
                  tuneLength=5)
cv.tree.pred1 <- predict(cv.tree1, testSplit2)
confusionMatrix(cv.tree.pred1, testSplit2$Class)
roc.curve(cv.tree.pred1, testSplit2$Class, plotit = T)
#AUC:0.953
#Sensitivity:0.9122
#Specificty:0.9794

# #model 2 on entire test dataset
# cv.tree.pred2 <- predict(cv.tree1, testSplit)
# confusionMatrix(cv.tree.pred2, testSplit$Class)
# roc.curve(cv.tree.pred2, testSplit$Class, plotit = T)
# # AUC ~0.52


### Naive bayes for task 2
set.seed(4356)
nb.model <- naiveBayes(Class ~ ., data = trainSplit2)
nb.pred <- predict(nb.model, testSplit2, type = "class")
table(nb.pred, testSplit2$Class)
confusionMatrix(nb.pred, testSplit2$Class)
roc.curve(nb.pred, testSplit2$Class, plotit = T)
#AUC 0.932

# # testing NB model  for the entire test dataset
# cv.tree.pred2 <- predict(nb.model, testSplit)
# confusionMatrix(cv.tree.pred2, testSplit$Class)
# roc.curve(cv.tree.pred2, testSplit$Class, plotit = T)
# #AUC 0.531


#########################TASK3###########################################

set.seed(4356)

rose_train <- ROSE(Class ~ ., data  = creditcard)$data

t.control <- trainControl(
  method = "cv", 
  number = 10, 
  savePredictions = TRUE)

cv.tree1 <- train(Class ~ ., data = rose_train, 
                  trControl = t.control, 
                  method = "rpart", 
                  tuneLength=5)
cv.tree.pred1 <- predict(cv.tree1, testSplit2)
confusionMatrix(cv.tree.pred1, testSplit2$Class)
roc.curve(cv.tree.pred1, testSplit2$Class, plotit = T)
#AUC:0.953
#Sensitivity:0.9122
#Specificty:0.9794

# #model 2 on entire test dataset
# cv.tree.pred2 <- predict(cv.tree1, testSplit)
# confusionMatrix(cv.tree.pred2, testSplit$Class)
# roc.curve(cv.tree.pred2, testSplit$Class, plotit = T)
# # AUC ~0.52


#SVM
svm.model <- svm(Class ~ ., data = trainSplit2, kernel = "radial", cost = 1, gamma = 0.1)
svm.predict <- predict(svm.model, testSplit2)
confusionMatrix(testSplit2$Class, svm.predict)
roc.curve(svm.predict, testSplit2$Class, plotit = T)
#on the entire test set
cv.tree.pred2 <- predict(svm.model, testSplit)
roc.curve(cv.tree.pred2, testSplit$Class, plotit = T)
confusionMatrix(cv.tree.pred2, testSplit$Class)

#bagged tree
ctrl <- trainControl(method = "cv", number = 10,
                     classProbs = TRUE,
                     summaryFunction = twoClassSummary
)

set.seed(5627)
treebag_model <- train(Class ~ ., data = trainSplit2, 
                       method = "treebag",
                       nbagg = 50,
                       metric = "ROC",
                       trControl = ctrl)
cv.tree.pred2 <- predict(treebag_model, testSplit2)
roc.curve(cv.tree.pred2, testSplit2$Class, plotit = T)
confusionMatrix(cv.tree.pred2, testSplit2$Class)


##Giving best results Random Forest
library(randomForest)
model.rf <- randomForest(Class ~ ., data =trainSplit2 , ntree = 1000, importance = TRUE)
cv.tree.pred2 <- predict(model.rf, testSplit2)
roc.curve(cv.tree.pred2, testSplit2$Class, plotit = T)
confusionMatrix(cv.tree.pred2, testSplit2$Class)
#better results AUC 0.977

# #on the entire test set
# cv.tree.pred2 <- predict(model.rf, testSplit)
# roc.curve(cv.tree.pred2, testSplit$Class, plotit = T)
# confusionMatrix(cv.tree.pred2, testSplit$Class)



