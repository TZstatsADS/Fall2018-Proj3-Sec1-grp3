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
	(Picture 1)
	+ Then we tried to build XXXXX models, including GBM, SVM, XgBoost, Random Forest, Neural Network, AdaBoost, Logistic Regression and Classification Trees. In model assessment part, XgBoost outperforms other models so we choose it as our proposed model:
	(Picture 2)
	+ Comparing with the baseline model, XgBoost model improves in both efficiency and accuracy parts:
	(Picture 3)
	
	
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md))
+ Project leader:
	+ Yingqiao Zhang
+ Major contributor:
	+ Xiaoyi Li, Shiqing Long
+ Equal contribution：
	+ Ghada Jerfel, 
	+ Peilin Li: Code feature.R and superResolution.R files, edit Github 

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
