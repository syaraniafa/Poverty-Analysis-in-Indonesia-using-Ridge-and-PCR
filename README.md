# Poverty Analysis in Indonesia using Multiple Linear Regression, Ridge Regression, and Principal Component Regression (PCR)

## Abstract
Poverty is a critical issue globally, obstructing a country’s growth and prosperity. This study focuses on identifying and analyzing key factors that significantly impact poverty levels in Indonesia. Multiple regression techniques such as Multiple Linear Regression, Ridge Regression, and Principal Component Regression (PCR) were employed to assess the correlation between various independent variables and poverty.

Due to violations of the linearity assumption in the multiple regression model, particularly multicollinearity, Ridge Regression and PCR were used as alternative models to evaluate the relationship between independent variables and poverty. Both Ridge Regression and PCR results indicated that average wage per hour is a significant factor influencing poverty levels in a city. These models also exhibited strong fit with R² scores of 0.87 (Ridge) and 0.78 (PCR), reflecting the models' ability to explain a substantial proportion of the variance in poverty.

Additionally, PCR revealed that the illiteracy rate also plays a significant role in influencing poverty within a city. The results underscore the importance of wage and education variables in poverty reduction efforts in Indonesia.

## Dataset
The dataset used for this analysis includes various socio-economic factors affecting poverty across different cities in Indonesia. The dependent variable is poverty level, while independent variables include average wages, literacy rate, and other socio-economic indicators.

## Key Tasks
1. **Multiple Linear Regression** <br>
The initial analysis was performed using Multiple Linear Regression to identify variables that significantly impact poverty. However, this model violated the assumption of no multicollinearity, leading to unreliable estimates of the relationship between independent variables and poverty.

2. **Ridge Regression** <br>
To address multicollinearity, Ridge Regression was implemented. This method adds a penalty to the size of the coefficients, thus mitigating the issue of multicollinearity and improving model stability.
    - **Key Findings**: Average wage per hour is a significant predictor of poverty, with an R² score of 0.87, indicating a good fit to the data.

3. **Principal Component Regression (PCR)** <br>
Principal Component Regression (PCR) was employed as an additional method to handle multicollinearity by transforming the independent variables into principal components. PCR reduces dimensionality and focuses on components that explain the most variance in the data.
    - **Key Findings**: Both the average wage per hour and illiteracy rate were identified as significant predictors of poverty, with an R² score of 0.78.

4. **Model Comparison** <br>
The performance of the **Ridge Regression** and **PCR** models was compared using their R² scores, and both showed strong predictive capabilities. Ridge Regression provided a slightly better fit to the data with a higher R² score, but PCR offered additional insights into the importance of literacy in combating poverty.

## Conclusion
This project reveals that **average wage per hour** and **illiteracy rate** are critical factors influencing poverty in Indonesia. Ridge Regression and Principal Component Regression both offer robust models for predicting poverty levels, with Ridge Regression demonstrating slightly better performance. The findings underscore the need for targeted interventions focusing on wage growth and education to alleviate poverty.

## Contributors
1. 2502042473 - DI RAJA QUSAYYI RABBANI
2. 2540122716 - REYZA RAHMATSYAH
3. 2502037864 - SYARANI AFA NATIRA KUSUMAH
