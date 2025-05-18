
# AI/ML Diabetes Risk Prediction End-To-End Project
                                                      
                                                  
<p align="center">
<img src="DiaWellness App/DiaWellness_App_Demo.gif" width="800"/>
</p>



### 📝Description 
**DiaWellness** is an AI/ML-powered interactive web application developed in R Shiny and deployed on [shinyapps.io](https://www.shinyapps.io/). Leveraging Real-World Data (RWD), it delivers real-time diabetes risk predictions based on user-input health data, along with visual probability estimates, health-management recommendations sourced from publicly available data, and analysis of model performance metrics.

### Live : [DiaWellnes App](https://zkiymp-riya-bhandari.shinyapps.io/DiaWellnessApp/) 


## 💉🩸Diabetes in Recent Years
According to projections by the International Diabetes Federation (IDF), by the year 2050, approximately 1 in 8 adults—an estimated 853 million people—will be living with diabetes, marking a 46% increase. Over 90% of these cases are expected to be type 2 diabetes, which is influenced by a combination of socioeconomic, demographic, environmental, and genetic factors. In India alone, the Indian Council of Medical Research (ICMR) estimated in 2023 that 101 million people—11.4% of the population—are currently living with diabetes.

## 🎯Motivation
Coming from a biotech background and having worked in the healthcare industry, I love staying updated on new medical breakthroughs. Upon completion of machine learning and deep learning studies, I was intrigued to work on ML project related to real world healthcare problem and came across [Pima Indians Diabetes Database](https://archive.ics.uci.edu/dataset/34/diabetes)  featured on UCI and Kaggle.

 What began as an exploratory data analysis and model comparison quickly turned into a full-fledged machine learning project, I started by implementing five supervised algorithms—Logistic Regression, K-Nearest Neighbors, Decision Tree, Random Forest, and Support Vector Machine. My curiosity led me to delve deeper by incorporating SMOTE and GridSearchCV for hyperparameter tuning which brought the model performance to the next level.
 
Just when I thought the project was done, a nudge in my brain cell pushed me further. I wanted to see my work come to life. That’s when I decided to build an interactive web application using R Shiny. The result? A user-friendly, AI/ML-powered app for real-time diabetes risk prediction— **End-to-End Healthcare ML project**.




## Data and Stats
**Source:** Pima Indians Diabetes Database featured on UCI and Kaggle

**Observations:** 768 Female Data

**Column Name and Data Types:**

1. Pregnancies - Number of times pregnant

2. Glucose - Plasma glucose concentration of 2 hours in an oral glucose tolerance test

3. BloodPressure - Diastolic blood pressure (mm Hg)

4. SkinThickness - Triceps skin fold thickness (mm)

5. Insulin - 2-Hour serum insulin (mu U/ml)

6. BMI - Body mass index (weight in kg/(height in m)^2)

7. DiabetesPedigreeFunction	- Diabetes pedigree function

8. Age - Age (years)

9. Outcome - Class variable (0 or 1)


```r
Rows: 768
Columns: 9
$ Pregnancies              <int> 6, 1, 8, 1, 0, 5, 3, 10, 2, 8, 4, 10, 10, 1, 5…
$ Glucose                  <int> 148, 85, 183, 89, 137, 116, 78, 115, 197, 125,…
$ BloodPressure            <int> 72, 66, 64, 66, 40, 74, 50, 0, 70, 96, 92, 74,…
$ SkinThickness            <int> 35, 29, 0, 23, 35, 0, 32, 0, 45, 0, 0, 0, 0, 2…
$ Insulin                  <int> 0, 0, 0, 94, 168, 0, 88, 0, 543, 0, 0, 0, 0, 8…
$ BMI                      <dbl> 33.6, 26.6, 23.3, 28.1, 43.1, 25.6, 31.0, 35.3…
$ DiabetesPedigreeFunction <dbl> 0.627, 0.351, 0.672, 0.167, 2.288, 0.201, 0.24…
$ Age                      <int> 50, 31, 32, 21, 33, 30, 26, 29, 53, 54, 30, 34…
$ Outcome                  <int> 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1…
```


**Statistics**
```r
  Pregnancies        Glucose      Blood_Pressure   Skin_Thickness 
 Min.   : 0.000   Min.   :  0.0   Min.   :  0.00   Min.   : 0.00  
 1st Qu.: 1.000   1st Qu.: 99.0   1st Qu.: 62.00   1st Qu.: 0.00  
 Median : 3.000   Median :117.0   Median : 72.00   Median :23.00  
 Mean   : 3.845   Mean   :120.9   Mean   : 69.11   Mean   :20.54  
 3rd Qu.: 6.000   3rd Qu.:140.2   3rd Qu.: 80.00   3rd Qu.:32.00  
 Max.   :17.000   Max.   :199.0   Max.   :122.00   Max.   :99.00  
    Insulin           BMI        Diabetes_Pedigree_Function      Age       
 Min.   :  0.0   Min.   : 0.00   Min.   :0.0780             Min.   :21.00  
 1st Qu.:  0.0   1st Qu.:27.30   1st Qu.:0.2437             1st Qu.:24.00  
 Median : 30.5   Median :32.00   Median :0.3725             Median :29.00  
 Mean   : 79.8   Mean   :31.99   Mean   :0.4719             Mean   :33.24  
 3rd Qu.:127.2   3rd Qu.:36.60   3rd Qu.:0.6262             3rd Qu.:41.00  
 Max.   :846.0   Max.   :67.10   Max.   :2.4200             Max.   :81.00  
    Outcome     
 Min.   :0.000  
 1st Qu.:0.000  
 Median :0.000  
 Mean   :0.349  
 3rd Qu.:1.000  
 Max.   :1.000
```


**Percenatge Distribution of Individuals With/Without Diabetes in Dataset**
```r
Outcome   n     percentage
<int>   <int>     <dbl>
 0	  500	    65		
 1	  268	    35

```






## 🔭 Project Scope
To build the best possible diabetes prediction model, a comprehensive analysis was conducted on the most popular supervised machine learning algorithms. Their performance was evaluated both with and without the application of SMOTE for handling class imbalance, alongside hyperparameter tuning using Grid Search CV. The model with the highest overall performance—assessed primarily by the ROC-AUC metric—was selected for deployment. Check out, detailed methodology and results in the [NoteBook/Diabetes_Risk_Prediction.ipynb]notebook:

### Approach

#### 🧹 Data preprocessing 
•	Data Cleaning and Outlier Detection

•	Applied Imputation on Missing data

•	Min-Max normalization on Training data

•	Feature Selection using Mutual Information

#### 📈 Exploratory Data Analysis
•	Distribution of Patients with or without Diabetes

•	Distribution of Independent Features

•	Boxplot analysis (Independent Features vs Outcome)

•	Correlation Matrix

•	Distribution of Scaled Independent Features

•	Confusion Matrix of Tuned ML models

#### 🤖 Model 
•	Logistic Regression (LR)

•	K-Nearest Neighbors (KNN)

•	Decision Tree (DT)

•	Random Forest (RF)

•	Support Vector Machine (SVM)

#### 🛠 Model Tuning 
•	SMOTE for Handling Class Imbalance

•	Hyperparameter Optimization via Grid Search Cross-Validation

#### 📉 Model Evaluation
•	ROC-AUC (Before and After Model Tuning)

•	Performance Metrics (Before and After Model Tuning)

#### 🚀 Model Deployment

•	R-Shinyapps

## Model Performance 
 
Overall, SVM is the most effective model post-tuning, delivering the strongest balance of accuracy, precision, and recall for high-quality healthcare related predictions.

## 🌐 Interactive Web-App Features
•	**Diabetes Risk Assessment:** Input key health parameters including Pregnancies, Glucose, Insulin, BMI, and Age to evaluate diabetes risk.

•	**Real-Time Probability Prediction:** Receive instant risk scores indicating the likelihood of having or not having diabetes, complemented by percentile rankings and visual indicators.

•	**Personalized Health Recommendations:** Access curated health management advice based on publicly available data, tailored for both individuals at risk of diabetes and those without diabetes.

•	**Model Performance Metrics:** View key evaluation metrics such as Precision, Recall, F1 Score, and Accuracy to understand the predictive model’s effectiveness.


## 💡 Just for Fun 

In a World full of 
<a href="https://icons8.com/icon/13441/python" target="_blank">
  <img src="https://img.icons8.com/color/48/000000/python--v1.png" alt="Python Icon" height="30"/>
</a>, Let's Make 
<a href="https://www.r-project.org/" target="_blank">
  <img src="https://upload.wikimedia.org/wikipedia/commons/1/1b/R_logo.svg" alt="R Logo" height="30">
</a>
more Shiny!✨


## Interaction

I warmly welcome your feedback and suggestions. Please feel free to reach out via:

[![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:bhandarirhea0697@gmail.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/riya-bhandari-y)


## Thank You!

Thanks so much for taking the time to check out my first end-to-end ML project and my very first deployed app. 

I really appreciate your interest!





