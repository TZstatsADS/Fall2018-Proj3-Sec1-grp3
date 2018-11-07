## This rmd file is used for tuning parameters in xgboost model
supply <- function(featMat,labMat){
 lrn <- makeLearner("regr.xgboost")
 model_Params <- makeParamSet(
        makeIntegerParam("max_depth",lower=1,upper=10),
        makeNumericParam("lambda",lower=0.55,upper=0.60),
        makeNumericParam("eta", lower = 0.001, upper = 0.5),
        makeNumericParam("subsample", lower = 0.10, upper = 0.80),
        makeNumericParam("min_child_weight",lower=1,upper=5),
        makeNumericParam("colsample_bytree",lower = 0.2,upper = 0.8)
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
supply(featMat,labMat)
 #Tune result:
 #Op. pars: max_depth=4; lambda=0.584; eta=0.256; subsample=0.522; min_child_weight=3.01; colsample_bytree=0.485;

 