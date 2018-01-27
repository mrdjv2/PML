library(knitr)
library(caret)
library(rpart)
library(rpart.plot)
library(rattle)
library(randomForest)
library(corrplot)

#From Local

# Getting the data


setwd("C://coursera//PML")

training <- read.csv("pml-training.csv")
testing  <- read.csv("pml-testing.csv")

#Classes to predict

unique(training$classe)

# Setting up a training set without names an times

train_index<-createDataPartition(training$classe, p=.75, list = FALSE)

train_small<-training[train_index,-(1:4)]
test_small<-training[-train_index,-(1:4)]


#Data preparation: Values with almost zero variance will be dismissed as well
#as well as the na-values:

nearzv<-nearZeroVar(train_small)

train_small<-train_small[,-nearzv]
test_small<-test_small[,-nearzv]


almostna    <- sapply(train_small, function(x) mean(is.na(x))) > 0.95
train_small <- train_small[, almostna==FALSE]
test_small  <- test_small[, almostna==FALSE]

