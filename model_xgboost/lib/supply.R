## This rmd file is used for tuning parameters in xgboost model
supply <- function(featMat,labMat){
 lrn <- makeLearner("regr.xgboost")
 model_Params <- makeParamSet(
        makeIntegerParam("max_depth",lower=3,upper=4),
        makeNumericParam("lambda",lower=0.58,upper=0.60),
        makeNumericParam("eta", lower = 0.250, upper = 0.30),
        makeNumericParam("subsample", lower = 0.50, upper = 0.55),
        makeNumericParam("min_child_weight",lower=3,upper=4),
        makeNumericParam("colsample_bytree",lower = 0.4,upper = 0.5)
    )
 
 cv_folds <- makeResampleDesc("CV", iters = 3)
 featMat2<-cbind(featMat,labMat)
 featMat2<-as.data.frame(featMat2)
 ml_task <- makeRegrTask(data=featMat2,target="labMat")
 random_tune <- makeTuneControlRandom(maxit = 1L)
 tuned_model <- tuneParams(learner = lrn,task = ml_task,
                                                    resampling = cv_folds,
                                                     measures = rsq,       # R-Squared performance measure, this can be changed to one or many
                                                     par.set = model_Params,
                                                     control = random_tune,
                                                     show.info = FALSE)
 return(tuned_model)
}