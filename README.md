# Healthcare Finance & Development in Africa(2015–2019): A SQL ANALYSIS

From 2015 to 2019, healthcare development and financing in African countries were a topic of significant concern. Many countries on the continent face significant challenges in providing adequate healthcare services to their citizens due to a lack of funding, inadequate infrastructure, and poor management practices. As a result, healthcare outcomes in many African countries lagged behind those of developed nations.
This project aims to analyze the state of healthcare development and financing in selected African countries between 2015 and 2019, with a particular focus on understanding the factors that contribute to disparities in healthcare outcomes. Through this analysis, I hope to answer the question: What was the state of healthcare development in these countries during the period under review? 
By conducting this analysis of healthcare development and financing from 2015 to 2019, I sought to gain a deeper understanding of the challenges and opportunities in the sector in African countries. Ultimately, to provide insights that can inform policies and initiatives aimed at improving healthcare outcomes and reducing disparities in the region.

## TOOLS & TECHNIQUES
The tools and techniques used to analyze the data are:
Data Extraction: I searched for open data sources and picked the Health, Nutrition, and Population (HNP) dataset from the World Bank open data repository. The dataset provides key health, nutrition, and population statistics gathered from various international and national sources. The data was downloaded as a filtered CSV file with African countries and 23 indicators relating to workforce, infrastructure, and financing are the focus. Some of the indicators used are 
Current health expenditure (% of GDP), Current health expenditure per capita (current US$), 
Domestic general government health expenditure (% of GDP), 
Domestic private health expenditure (% of current health expenditure), 
External health expenditure per capita (current US$), etc
I created a legend .csv file that provides a detailed explanation of the indicators (series name) used, their corresponding series code, and series description and can be found in my GitHub repository along with other relevant data

### Data Cleaning: 
I cleaned the data using Google Sheets. I checked for duplicates, used the TRIM function to remove trailing or leading spaces, used spell check, and created a filter to check for blanks which revealed null values for some countries and series codes. The records of countries with missing values for the entire time series were deleted. The cleaned .csv file contained 1242 rows and 11 columns.

### SQL: 
The cleaned dataset was uploaded to MS SQL Server Management Studio, and a ```Healthcare_WorldBank``` database was created from the Object Explorer section of SQL Server Management Studio. A ```WorldBankData``` table was created inside the ```Healthcare_WorldBank``` database. SQL was used to analyze the dataset. Queries were run to see if the data was properly imported, count the number of rows to see if it was complete, round the fields containing float data to the nearest 2 decimal places, and created a #wbd temp table for my session

![query_1](https://user-images.githubusercontent.com/113455719/234799414-1214df8b-648d-49dc-acc3-12228275446c.png)

![query_2](https://user-images.githubusercontent.com/113455719/234799514-cf871a74-b04a-41a9-a8dc-07387b35bb9f.png)

![query_3](https://user-images.githubusercontent.com/113455719/234800460-1f406913-f07d-4b79-b942-67645c1a04a5.png)

![query_4](https://user-images.githubusercontent.com/113455719/234800531-e291bf98-1d1c-4de0-a683-6f4279076e50.png)

### Analysis: 
I used SQL queries to answer questions about the healthcare industry in Africa. I analyzed how much African countries spend on health, the countries with the highest current health expenditure in each year, the countries with the lowest current health expenditure in each year, the countries that are the heaviest spenders per capita and per capita at purchasing power parity, and the countries with the highest and lowest health expenditure per capita. The results were presented in tables through SQL.

### 1. How much do African countries spend on health as a percentage of GDP & which countries have the highest and lowest health expenditure (% of GDP)

![query_5](https://user-images.githubusercontent.com/113455719/234800947-2fb2201d-2cce-4cc2-b24c-c6bc5d80e69a.png)

![query_6](https://user-images.githubusercontent.com/113455719/234800956-77738a37-412b-4eb6-b0ae-b1da73e7a46e.png)

Sierra Leone in 2015 & 2016 spent the highest % of its GDP on healthcare with 20.41% & 16.53% while in 2017, 2018 & 2019, Malawi, Central African Republic, and Lesotho respectively spent the most, with 10.89%, 11% & 11.27% of their GPD was spent on healthcare.
Congo Republic in 2015, 2017, 2018 & 2019 (2.46%, 2.52%, 1.94% & 2.08%) spent the least on healthcare in terms of GDP % with Angola in 2016 (2.71%) temporarily disrupting the trend.

![query_7](https://user-images.githubusercontent.com/113455719/234801134-b7bf9447-11e7-4585-a11b-1514b45e144f.png)

The countries of Sierra Leone, Malawi, Central African Republic, Lesotho, Congo Rep, and Angola show a range of health expenditures as a percentage of their GDP, with Lesotho being the highest spender per capita and at purchasing power parity with $124.69 (in 2018) and $313.61 respectively. On the other hand, CAR has the lowest health expenditure per capita at $19 (in 2015) and $53.69 at purchasing power parity.

![query_8](https://user-images.githubusercontent.com/113455719/234801138-694fa464-fb49-464c-9ab1-4dd73205f805.png)

Interestingly, it is noteworthy that the top 5 countries that spend the most on health expenditure per capita - Seychelles, Mauritius, South Africa, Namibia, and Botswana - often swap positions annually

![query_9](https://user-images.githubusercontent.com/113455719/234801385-c33a6967-093f-4669-8e3f-7ca15eff88f0.png)

On average, their health expenditure per capita stands at $779.20, $606.82, $522.89, $454.48, and $450.43, respectively. These countries also have an average health expenditure per capita at purchasing power parity of $1334.80, $1266.92, $1131.04, $929.63, and $1021.76, respectively.

![query_10](https://user-images.githubusercontent.com/113455719/234801395-d717fe6f-eab8-45af-b3d2-2d0ef5794e52.png)

At the bottom of the table in terms of current health expenditure as a percentage of GDP, the countries occupying the 5 least positions between 2015–2019 are Congo Dem. Rep & Burundi appeared the most followed by Eritrea, Madagascar, Ethiopia, Central African Republic, Niger, Gambia & Sudan.

![query_12](https://user-images.githubusercontent.com/113455719/234801629-8737100f-4e7f-4290-8ae6-a250ecbac5fc.png)

![result_2](https://user-images.githubusercontent.com/113455719/234801865-30f866cd-8977-4447-891e-490b0227c588.png)



