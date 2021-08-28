---
layout: home
profile_picture:
  src: /assets/img/profile-pic.jpg
  alt: website picture
---

# Introduction

This project uses the House Prices data gotten from<a href="https://www.kaggle.com/c/house-prices-advanced-regression-techniques">Kaggle</a>

I have seen people in Kaggle use Linear Regression, Generalized Linear Regression, XGBoost, Support Vector Machine, ... This article is about using <a href="https://docs.h2o.ai/h2o/latest-stable/h2o-docs/automl.html">Auto Machine Learning (AutoML) with package h2o</a> 
  
The current version of AutoML trains and cross-validates the following algorithms (in the following order):  three pre-specified XGBoost GBM (Gradient Boosting Machine) models, a fixed grid of GLMs, a default Random Forest (DRF), five pre-specified H2O GBMs, a near-default Deep Neural Net, an Extremely Randomized Forest (XRT), a random grid of XGBoost GBMs, a random grid of H2O GBMs, and a random grid of Deep Neural Nets. 

AutoML then trains two Stacked Ensemble models, one from all of the models created, one from the best model from each algorithm class/family. Both of the ensembles should produce better models than any individual model from the AutoML run except for some rare cases.

The advantage of using AutoML is it can help produce a better prediction. Besides, after fitting models, we can do the model explanation that can help recognize "important" factors that affect the outcomes and also how they affect the outcomes. <a href="https://christophm.github.io/interpretable-ml-book/">Link to the"Interpretable Machine Learning" book</a>
  
My goal for this project is to provide a detailed explanation of how to use AutoML with data having a continuous outcome. All of the codes are put in functions with detailed explanations that can be conveniently used later on with other data.  I will first write some simple code for exploring the data then jump into our main part, AutoML.


# Some note before working with the Project

1- You need to create a project on R. This is <a href="https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects">how</a>. It will make your project be much organized and make sure that your code, data, and results will not be mixed up together.\

2- With this project, I first create a new project on a folder with the same name, let say `ml_with_r_h2o`. Then I will create a folder, named `code` that will contain all of the Rfile.script or Rfilename.Rmd that I will use. Also, create a folder named  `house_dat` that contains train and test data.

3- It is better to read this article when you are familiar with data wrangling using tidyverse. A good book for studying is <a href="(https://r4ds.had.co.nz/6">R for Data Science</a> or a more advanced book, <a href="https://adv-r.hadley.nz/">Advanced R</a>
  
Here are some things that I use in this project that you might found in these books or use the link provided:
  - How to reuse functions that you create in  Scrips: use [source](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/source) of a function.\
  - Using [glue](https://glue.tidyverse.org/) to write shorter and well-organized R code.\
  - ... many more (You definitely need to read the whole book <a href="(https://r4ds.had.co.nz/6">R for Data Science</a>  :smirk:
  


