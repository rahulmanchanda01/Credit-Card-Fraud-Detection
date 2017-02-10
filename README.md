# Credit-Card-Fraud-Detection

We would like to test various sampling techniques that would work in case of skewed data. The idea is to check how these preprocessing techniques work when there is an overwhelming majority class present in a dataset, often a problem in fraud detection We will also try the use of Caret package in, a panacea for all machine learning tasks in R. We will try various models such as Decision trees, Random forest, Logistic regression SVM and XGboost. We will also gain better understanding of which evaluation metric is better suited for these sorts of problems where accuracy often fails to paint the right picture

1)	Basic dataset information and visualization

2)	Basic modeling

a.	Logistic model on the entire dataset (Train and Test)
b.	Logistic model on the SMOTE dataset
c.	Running the SMOTE model on the entire dataset

It will be clear that the sampling technique is required for this dataset

3)	Preprocessing the data
a.	Under-sampling
b.	Over-sampling
c.	SMOTE
d.	ROSE

We will model on all these 4 datasets to see which one is a better method for this data

4)	Advanced modeling

a.	Decision tree on all 4 datasets
b.	Random forest on all 4 datasets
c.	SVM on all 4 (with hyper-parameter tuning) 
d.	XGBoost on all 4 (with hyper-parameter tuning)

5)	Model selection and variable importance

a.	Considering the Decison tree as the base model, we will evaluate all the models built in step 3 to choose the best model
b.	We will apply the best model on the entire dataset to get the evaluation metrics
c.	Identify the most important variables

6)	Future Score
a.	Trying different anomaly detection techniques as given on the link shared below:
URL: http://ac.els-cdn.com/S1877050915023479/1-s2.0-S1877050915023479-main.pdf?_tid=74d51e1c-ee36-11e6-864d-00000aab0f27&acdnat=1486583013_38d61cfb7eff97e14685f11986f38256
