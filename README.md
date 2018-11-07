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
	+ First, we draw some samples in the low-resolution images. For each sample, we extract features from 8 neighboring pixels in the low-resolution images and features from 4 corresponding pixels in the high-solution images, then we save them in 2 feature matrices, respectively. Second, we train our models using these features and save parameters of the model with the best performance.
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md))
+ Project leader:
	+ Yingqiao Zhang
+ Major contributor:
	+ Xiaoyi Li, Shiqing Long
+ Equal contribution：
	+ Ghada Jerfel: coded the linear regression model, edited the readme file, and prepared the presentation slides.
	+ Peilin Li

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
