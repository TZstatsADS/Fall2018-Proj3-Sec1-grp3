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
	+ Firstly, we draw some samples in the low-resolution images. For each sample, we extract features from 8 neighbor pixels near it in low-resolution images and features from 4 corresponding pixels in high-solution images
	
**Contribution statement**: ([default](doc/a_note_on_contributions.md))
+ Project leader:
	+ Yingqiao Zhang
+ Major contributor:
	+ Xiaoyi Li, 
+ Equal contribution：
	+ Ghada Jerfel, 

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
