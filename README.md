# Health Factors' Influence on Stroke Occurrence

## Author
Glynn Smith

## Overview
This project investigates the relationship between various health factors and the occurrence of stroke. The primary objective is to determine whether smoking status significantly impacts stroke risk and to build a predictive model using logistic regression. The study analyzes data from 5,110 patients, identifying key predictors and evaluating the model's predictive performance.

## Dataset
- **Source**: Kaggle (Stroke Prediction Dataset used in McKinsey Analytics Hackathon)
- **Size**: 5,110 observations (reduced after data cleaning)
- **Features**:
  - **Demographics**: Gender, Age
  - **Health Conditions**: Hypertension, Heart Disease
  - **Lifestyle Factors**: Smoking Status
  - **Biometrics**: Average Glucose Level, BMI
  - **Other Factors**: Work Type, Residence Type
  - **Target Variable**: Stroke occurrence (binary: 0 = No, 1 = Yes)

## Objectives
- Assess whether smoking status is a significant predictor of stroke occurrence.
- Build a logistic regression model to predict stroke occurrence using health factors.
- Identify the most important predictors influencing stroke risk.

## Methodology
### Data Cleaning & Transformation
- Removed missing values (201 BMI values and unknown smoking status cases).
- Dropped the "Other" category from gender.
- Conducted exploratory analysis with box plots and correlation matrices.
- Standardized continuous variables where necessary.

### Statistical Analysis
- Used **multiple logistic regression** as the primary modeling approach.
- Applied **purposeful selection** and **stepwise regression (AIC optimization)** for feature selection.
- Evaluated multicollinearity using **VIF values**.
- Assessed model assumptions and predictive performance.

### Model Selection
- Built an initial model including all predictor variables.
- Stepwise selection dropped **smoking status** and **gender** due to lack of significance.
- The final model included:
  - **Age**
  - **Hypertension**
  - **Heart Disease**
  - **Average Glucose Level**

## Final Model
The final logistic regression model predicts stroke occurrence using the following predictors:
- **Age** (positive association)
- **Hypertension** (significant predictor)
- **Heart Disease** (significant predictor)
- **Average Glucose Level** (weak but significant predictor)

## Results
- **Smoking status was not a significant predictor** and was excluded from the final model.
- The model achieved:
  - **Sensitivity** = 78.71%
  - **Specificity** = 72.45%
  - **AUC (Area Under the Curve)** = 0.8225

## Limitations
- **Validity of the data was a concern**, as the dataset's exact source was unclear despite its use in prior hackathons and published analyses.
- **Data quality issues**: Approximately **30% of the data was removed** due to missing values, particularly in the BMI and smoking status variables.
- **Potential selection bias** due to missing data handling.
- **Self-reported data** may introduce inaccuracies, especially for lifestyle variables like smoking.
- **Limited feature set**—additional lifestyle factors like **exercise frequency and diet** could improve predictions.

## Future Work
- Collect more transparent and complete datasets.
- Incorporate additional health and lifestyle factors.
- Explore **machine learning models** (e.g., decision trees, neural networks) for better predictive accuracy.

