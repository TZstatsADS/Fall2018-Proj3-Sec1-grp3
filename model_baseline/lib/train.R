#########################################################
### Train a classification model with training features ###
#########################################################

### Author: Chengliang Tang
### Project 3


train <- function(dat_train, label_train){
  
  ### Train a Gradient Boosting Model (GBM) using processed features from training images
  
  ### Input: 
  ###  -  features from LR images 
  ###  -  responses from HR images
  ### Output: a list for trained models
  
  ### load libraries
  library("gbm")
  
  ### creat model list
  modelList <- list()
  
  ### Train with gradient boosting model
  
  ### the dimension of response arrat is * x 4 x 3, which requires 12 classifiers
  ### this part can be parallelized
  
  for (i in 1:12){
    c1 <- (i-1) %% 4 + 1
    c2 <- (i-c1) %/% 4 + 1
   featMat <- dat_train[, , c2]
    labMat <- label_train[, c1, c2]
    fit_gbm <- gbm.fit(x=featMat, y=labMat,
                       n.trees=100,
                       distribution="gaussian",
                       interaction.depth=1, 
                       bag.fraction = 0.5,
                       verbose=FALSE)
    best_iter <- gbm.perf(fit_gbm, method="OOB", plot.it = FALSE)
    modelList[[i]] <- list(fit=fit_gbm, iter=best_iter)
  }
  
  return(modelList)
}
