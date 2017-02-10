# Credit-Card-Fraud-Detection

The datasets contains transactions made by credit cards in September 2013 by european cardholders. This dataset present transactions that occurred in two days, where we have 492 frauds out of 284,807 transactions. The dataset is highly unbalanced, the positive class (frauds) account for 0.172% of all transactions.

It contains only numerical input variables which are the result of a PCA transformation. Unfortunately, due to confidentiality issues, we cannot provide the original features and more background information about the data. Features V1, V2, ... V28 are the principal components obtained with PCA, the only features which have not been transformed with PCA are 'Time' and 'Amount'. Feature 'Time' contains the seconds elapsed between each transaction and the first transaction in the dataset. The feature 'Amount' is the transaction Amount, this feature can be used for example-dependant cost-senstive learning. Feature 'Class' is the response variable and it takes value 1 in case of fraud and 0 otherwise.

Given the class imbalance ratio, we recommend measuring the accuracy using the Area Under the Precision-Recall Curve (AUPRC). Confusion matrix accuracy is not meaningful for unbalanced classification.

The dataset has been collected and analysed during a research collaboration of Worldline and the Machine Learning Group (http://mlg.ulb.ac.be) of ULB (Université Libre de Bruxelles) on big data mining and fraud detection. More details on current and past projects on related topics are available on http://mlg.ulb.ac.be/BruFence and http://mlg.ulb.ac.be/ARTML

Please cite: Andrea Dal Pozzolo, Olivier Caelen, Reid A. Johnson and Gianluca Bontempi. Calibrating Probability with Undersampling for Unbalanced Classification. In Symposium on Computational Intelligence and Data Mining (CIDM), IEEE, 2015

We would like to test various sampling techniques that would work in case of skewed data. The idea is to check how these preprocessing techniques work when there is an overwhelming majority class present in a dataset, often a problem in fraud detection We will also try the use of Caret package in, a panacea for all machine learning tasks in R. We will try various models such as Decision trees, Random forest, Logistic regression SVM and XGboost. We will also gain better understanding of which evaluation metric is better suited for these sorts of problems where accuracy often fails to paint the right picture



************************************************************************

#Here is my approach to solve this problem

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
