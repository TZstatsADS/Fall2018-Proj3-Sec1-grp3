#########################################################
### Train a classification model with training features ###
#########################################################

### Author: Chengliang Tang
### Project 3


train <- function(dat_train, label_train){
  
  ### Train a Xgboost Model using processed features from training images
  
  ### Input: 
  ###  -  features from LR images 
  ###  -  responses from HR images
  ### Output: a list for trained models
  
  ### load libraries
  library("xgboost")
  
  ### creat model list
  modelList <- list()
  
  ### Train with Xgboost model and return model parameters that perform best
  best_para <- supply(feat_train[,,1], label_train[,2,1])
  
  ### the dimension of response arrat is * x 4 x 3, which requires 12 classifiers
  ### this part can be parallelized
  for (i in 1:12){
    ## calculate column and channel
    c1 <- (i-1) %% 4 + 1
    c2 <- (i-c1) %/% 4 + 1
    featMat <- dat_train[, , c2]
    labMat <- label_train[, c1, c2]
    dtrain <- xgb.DMatrix(data=featMat, label = labMat)
    ## get parameters by cross validation in supply.R
    params <- list(booster = "gblinear", objective = "reg:linear", 
                   eta=best_para$x$eta, gamma=best_para$x$gamma, max_depth=best_para$x$max_depth, 
                   min_child_weight=best_para$x$min_child_weight, subsample=best_para$x$subsample)
    xgbcv <- xgb.cv( params = params, data = dtrain, nrounds = 100, nfold = 5, showsd = T, stratified = T, print_every_n = 100, early_stop_round = 20, maximize = F) 
    xgb1 <- xgb.train (params = params, data = dtrain, nrounds = 23)
    modelList[[i]] <- list(fit=xgb1)
  }
  
  return(modelList)
}
