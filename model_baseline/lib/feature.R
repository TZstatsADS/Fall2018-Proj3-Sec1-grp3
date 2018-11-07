#############################################################
### Construct features and responses for training images###
#############################################################
# 
### Authors: Group3
### Project 3

feature <- function(LR_dir, HR_dir, n_points=1000){
  
  ### Construct process features for training images (LR/HR pairs)
  
  ### Input: a path for low-resolution images + a path for high-resolution images 
  ###        + number of points sampled from each LR image
  ### Output: an .RData file contains processed features and responses for the images
  
  ### Load libraries
  library("EBImage")
  n_files <- length(list.files(LR_dir))
  
  ### Create 2 empty matrices to store feature and label
  n_points <- 1000
  featMat <- array(NA, c( n_files * n_points, 8, 3))
  labMat <- array(NA, c( n_files * n_points, 4, 3))
  
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
  
  ### Function for calculating the difference of 1 point and corresponding 4 pixels
  output <- function(ori_row, ori_col){
    row <- ori_row
    column <- ori_col
    center <- zerodata[row + 1,column + 1,]
    response <- c(highdata[2*row-1,2*column,],
                  highdata[2*row-1,2*column-1,],
                  highdata[2*row,2*column-1,],
                  highdata[2*row,2*column,])
    return(response - center)
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
  
  ### Use loop to handle images
  for (i in 1:n_files){
    imgLR <- readImage(paste0(LR_dir,  "img_", sprintf("%04d", i), ".jpg"))
    imgHR <- readImage(paste0(HR_dir,  "img_", sprintf("%04d", i), ".jpg"))
    
    ### Sample n_points from imgLR and set their coordinates
    rowdim <- dim(imgLR)[1]
    coldim <- dim(imgLR)[2]
    samplerow <- sample(1:rowdim ,n_points,replace = TRUE)
    samplecolumn <- sample(1:coldim ,n_points,replace = TRUE)

    ### Padding raw LR image
    rawdata <- as.array(imgLR)
    zerodata <- array(apply(rawdata,3,paddingzero), dim=c(rowdim+2,coldim+2,3))
    
    ### Get HR image data ready
    highdata <- as.array(imgHR)
    
    ### Extract features from LR and HR images using 2 funuctions above
    LR_fea <- mapply(input, samplerow, samplecolumn)
    HR_fea <- mapply(output, samplerow, samplecolumn)
    
    ### Save the corresponding 8 values of each sample point from imgLR in featMat
    row1<- 1000*(i-1)+1
    row2<- row1+999
    featMat[row1:row2, , 1]<- t(LR_fea[1:8, ])
    featMat[row1:row2, , 2]<- t(LR_fea[9:16, ])
    featMat[row1:row2, , 3]<- t(LR_fea[17:24, ])
    
    ### Save the corresponding 4 sub-pixels of imgHR in labMat
    labMat[row1:row2, , 1]<- t(HR_fea[1:4, ])
    labMat[row1:row2, , 2]<- t(HR_fea[5:8, ])
    labMat[row1:row2, , 3]<- t(HR_fea[9:12, ])
    
  }
  ### Return a list of featMat and labMat
  return(list(feature = featMat, label = labMat))
}
