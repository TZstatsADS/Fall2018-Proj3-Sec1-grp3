# Project: Can you unscramble a blurry image? 


### [Full Project Description](doc/project3_desc.md)

Term: Fall 2018

+ Team #3
+ Team members
	+ Yingqiao Zhang
	+ Ghada Jerfel
	+ Xiaoyi Li
	+ Peilin Li
	+ Shiqing Long

+ Project summary: 
	+ In this project, we worked on assessing predictive models that improves on the gradient boosted stumps baseline model, hence allowing us to turn a low resolution image into a high resolution image. Ultimately, the process of model selection led to finding that the best model was XgBoost.
	+ Firstly, we do model training using features of several samples extracted from low-resolution images and high-resolution images. For each sample, we extract features from 8 neighbor pixels near it in low-resolution images and features from 4 corresponding pixels in high-solution images, save them in 2 feature matrices, respectively. Then we train our models using these features and save parameters of the model with best performance.
	![screenshot](model_baseline/doc/doc1.jpg)
	+ Then we tried to build 5 models, including GBM, SVM, XgBoost, Random Forest, Neural Network. In model assessment part, XgBoost outperforms other models so we choose it as our proposed model:
	![screenshot](model_baseline/doc/doc2.jpg)
	+ Comparing with the baseline model, XgBoost model improves in both efficiency and accuracy parts:
	![screenshot](model_baseline/doc/doc3.jpg)
	
	
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md))
+ Project leader:
	+ Yingqiao Zhang：Designed and organized the structure of whole project. Built and optimized the baseline model. Tuning parameters for the xgboost model. 
+ Major contributor:
	+ Xiaoyi Li: Build xgboost model and random forest model. Tuning parameters for the xgboost model and random forest model.
	+ Shiqing Long: Search methods to improve the baseline models. Applied svm as advanced model to improve the performance, do cv and calculate PSNR and MSE. Also prepared presentation slide.
+ Equal contribution：
	+ Ghada Jerfel: built the linear regression model, edited the readme file, as well as made the presentation slides.
	+ Peilin Li: Code feature.R and superResolution.R files, edit Github and make the presentation slides.

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
