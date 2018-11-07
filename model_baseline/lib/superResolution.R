########################
### Super-resolution ###
########################

### Author: Group3
### Project 3

superResolution <- function(LR_dir, HR_dir, modelList){
  
  ### Construct high-resolution images from low-resolution images with trained predictor
  
  ### Input: a path for low-resolution images + a path for high-resolution images 
  ###        + a list for predictors
  
  ### Load libraries
  library("EBImage")
  n_files <- length(list.files(LR_dir))
  
  ### Function for calculating the difference of 1 point and its neighbor 8 pixels in LR images
  input <- function(ori_row, ori_col){
    row <- ori_row+1
    column <- ori_col+1
    center <- zerodata[row,column,]
    neighbor <- c(zerodata[row-1,column-1,],zerodata[row-1,column,],
                  zerodata[row-1,column+1,],zerodata[row,column-1,],
                  zerodata[row,column+1,],zerodata[row+1,column-1,],
                  zerodata[row+1,column,],zerodata[row+1,column+1,])
    return(neighbor - center)
  }
  
  ### Function for padding zeros around the LR image
  paddingzero <- function(rawdata){
    zerodata <- cbind(matrix(rep(0,rowdim,nrow=rowdim)),
                      rawdata,
                      matrix(rep(0,rowdim),nrow=rowdim))
    zerodata <- rbind(rep(0,coldim+2),
                      zerodata,
                      rep(0,coldim+2))
    return(zerodata)
  }
  
  ### Function for adding LR images feature values to featMat 
  featMat_give <- function(featmatrix, LR_feature){
    featmatrix[, , 1]<- LR_feature[,1:8]
    featmatrix[, , 2]<- LR_feature[,9:16]
    featmatrix[, , 3]<- LR_feature[,17:24]
    return(featmatrix)
  }
  
  MSE <- 0
  
  ### Read LR/HR image pairs
  for(i in 1:n_files){
    imgLR <- readImage(paste0(LR_dir,  "img", "_", sprintf("%04d", i), ".jpg"))
    imgHR <- as.array(readImage(paste0(train_HR_dir,  "img", "_", sprintf("%04d", i), ".jpg")))
    pathHR <- paste0(HR_dir,  "img", "_", sprintf("%04d", i), ".jpg")
    rowdim <- dim(imgLR)[1]
    coldim <- dim(imgLR)[2]
    featMat <- array(NA, c(rowdim * coldim, 8, 3))
    
    totalrow <- rep(1:rowdim,rep(coldim,rowdim))
    totalcolumn <- rep(1:coldim,rowdim)

    ### Padding raw LR data
    rawdata <- as.array(imgLR)
    zerodata <- array(apply(rawdata,3,paddingzero), dim=c(rowdim+2,coldim+2,3))
    
    ### Extract features from LR and HR pictures
    LR_fea <- t(mapply(input, totalrow, totalcolumn))
    featMat <- featMat_give(featMat, LR_fea)
    
    ### Apply the modelList over featMat
    predMat <- test(modelList, featMat)
    
    ### Recover high-resolution from predMat and save in HR_dir
    mat_dims<- coldim*rowdim
    HR_col<- 1:coldim
    HR_row<- 1:rowdim
    
    HRMat_1<- array(predMat, dim = c(mat_dims, 4, 3))
    LRMat1<- array(c(rep(as.numeric(imgLR[,,1]), 4), 
                    rep(as.numeric(imgLR[,,2]), 4), 
                    rep(as.numeric(imgLR[,,3]), 4)), 
                    dim = c(mat_dims, 4, 3))
    HRMat_2<- HRMat_1+LRMat1
    HRMat_3<- array(NA, dim = c(2*rowdim, 2*coldim, 3))
    HRMat_3[2*HR_row-1, 2*HR_col-1, ]<- HRMat_2[, 1, ]
    HRMat_3[2*HR_row-1, 2*HR_col, ]<- HRMat_2[, 2, ]
    HRMat_3[2*HR_row, 2*HR_col-1, ]<- HRMat_2[, 3, ]
    HRMat_3[2*HR_row, 2*HR_col, ]<- HRMat_2[, 4, ]
    
    ### Set the path to save HR images
    HR_savepath<- paste0(HR_dir,  "img_", sprintf("%04d", i), ".jpg")
    writeImage(Image(HRMat_3, colormode="Color"), HR_savepath)
    MSE <- MSE + sum((HRMat_3 - imgHR)^2)/length(imgHR)
  }
  MSE <- MSE/n_files
  return(MSE)
}

