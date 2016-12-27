The titanic disaster app
========================================================
author: Christoph 
date: 27.12.2106
autosize: true


The idea
========================================================

- The idea came from kaggle.com
- kaggle.com is a data science webpage, which offers fun competitions
- For a couple of month they offered a competition with titanic passenger data
- The challenge was to find a prediction model based on a training set that best
   predicts survival during the titanic disaster
- For a given test set you you had to predict the survival and enter the result into the competition

How it works
========================================================

- The titanic disaster app shows first some histogram on different features of the original dataset and how survivors were distributed over passengers. 
- The four features I used for the prediction model can be used to view the orginal data as histogram. 
- In the second part of the application it is possible to enter age, gender, class and fare to predict, if a passenger was likely to survive. The result will be displayed by an icon, which should be self explaining.


The data used
========================================================



```r
titanicdata <- read.csv(url("https://dl.dropboxusercontent.com/u/36380459/titanic_survival_data.csv"), stringsAsFactors=TRUE)
head(titanicdata[,c(2,3,5,6,9,10,11)])
```

```
  Survived Pclass    Sex Age           Ticket    Fare Cabin
1        0      3   male  22        A/5 21171  7.2500      
2        1      1 female  38         PC 17599 71.2833   C85
3        1      3 female  26 STON/O2. 3101282  7.9250      
4        1      1 female  35           113803 53.1000  C123
5        0      3   male  35           373450  8.0500      
6        0      3   male  NA           330877  8.4583      
```

Data is also available on github: https://github.com/agconti/kaggle-titanic

The prediction model 1
========================================================

For the ease of use I decided to use the following features from the original data for the random forest prediction model.

- AGE  
- SEX  
- PASSENGER CLASS  
- FARE  

I used cross validation to get the best possible result and achieved an accuracy of 0.83 !!!


The prediction model 2
========================================================


```
Random Forest 

891 samples
  4 predictor
  2 classes: '0', '1' 

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 803, 802, 802, 802, 802, 802, ... 
Resampling results across tuning parameters:

  mtry  Accuracy   Kappa    
  2     0.8260637  0.6216023
  3     0.8225914  0.6191003
  4     0.8158745  0.6061151

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was mtry = 2. 
```
