Predicting Economic Variables Using the OECD STAN Database
========================================================
Course Project, Developing Data Products, Coursera/John Hopkins
--------------------------------------------------------
author: Mike Haymes
date: August 2014

Outline
========================================================


- Introduction
- Shiny App Instructions
- About the Data
- Prediction Methodology

Introduction
========================================================

- The associated Shiny App provides predictions for user-defined economic variables, based on user defined parameters for country, year, and industry. 
- Given the user's input, the application outputs the predicted value for the economic variable of interest, as well as the actual value observed, and the prediciton error in percentage.
- The model predicts using a sample of public data from the OECD's Structural Analysis Database (ISIC Rev. 4), based on a very simple linear autoregressive model. 
- This product was developed as part of the requirements of Coursera's Developing Data Products Course, offered by the John Hopkins' University's Bloomberg School of Public Health. 


Shiny App Instructions
========================================================

Using the radio buttons on the left sidebar menu....

1. Choose a year for prediction
2. Choose a country for prediction
3. Choose an industry for prediction

The application will output in the main panel the prediction, the true value and the prediction error in percent.  

**Note that the application may take about a minute or two to fully load.**


About the Data
========================================================

- Sample of public data available from the Organization for Economic Cooperation and Development (OECD), Structural Analysis Database (full data is available at stat.oecd.org)
- Industry Descriptions are based on the International System of Industry Classification (ISIC) Revision 4. 
- Database provides industry-specific economic data for a range of OECD countries, dating back to the mid 1980s. 
- See stat.oecd.org for full documentation


About the Data 2
=======================================================

Dataset Variables: 

- Cou: Country Code
- ind: industry or industry aggregation code (ISIC Rev. 4)
- Var: economic variable
- year
- Value: Value of economic Variable
- Data Notes

Country Coverage (Full STAN database)
=======================================================


```r
cList<-read.table("dimCOU.txt", header=FALSE, sep="|")
cList$V2
```

```
 [1] Australia       Austria         Belgium         Canada         
 [5] Chile           Czech Republic  Denmark         Estonia        
 [9] Finland         France          Germany         Greece         
[13] Hungary         Ireland         Iceland         Israel         
[17] Italy           Japan           Korea           Luxembourg     
[21] Mexico          Netherlands     New Zealand     Norway         
[25] Poland          Portugal        Slovak Republic Slovenia       
[29] Spain           Sweden          Switzerland     Turkey         
[33] United Kingdom  United States   West Germany   
35 Levels: Australia Austria Belgium Canada Chile ... West Germany
```



Prediction Methodology
=======================================================

- Purpose of the App is to demonstrate a Shiny application based on a very simple prediction model...model not chosen for prediction accuracy or appropriateness.
- A backcast prediction is generated using a linear autoregressive model, using the previous two periods of lagged data and the year as dependent variables.   
