# Project: Can you unscramble a blurry image? 

### Code lib Folder

The lib directory contains the code files of baseline model and xgboost model including feature, train, test, superesolution. Xgboost model has a supply file which is used for tuning parameter.

If you have both HR and LR images, and want to calculate PSNR using MSE, you need to:
1. Uncomment line 95, 97, 98 in superResolution.R file.
2. Uncomment line 166, 168, 178, 179 in main.Rmd. 
3. Comment line 165 in main.Rmd.