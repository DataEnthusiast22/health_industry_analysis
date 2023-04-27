# Healthcare Finance & Development in Africa(2015–2019): A SQL ANALYSIS

From 2015 to 2019, healthcare development and financing in African countries were a topic of significant concern. Many countries on the continent face significant challenges in providing adequate healthcare services to their citizens due to a lack of funding, inadequate infrastructure, and poor management practices. As a result, healthcare outcomes in many African countries lagged behind those of developed nations.
This project aims to analyze the state of healthcare development and financing in selected African countries between 2015 and 2019, with a particular focus on understanding the factors that contribute to disparities in healthcare outcomes. Through this analysis, I hope to answer the question: What was the state of healthcare development in these countries during the period under review? 
By conducting this analysis of healthcare development and financing from 2015 to 2019, I sought to gain a deeper understanding of the challenges and opportunities in the sector in African countries. Ultimately, to provide insights that can inform policies and initiatives aimed at improving healthcare outcomes and reducing disparities in the region.

## TOOLS & TECHNIQUES
The tools and techniques used to analyze the data are:
Data Extraction: I searched for open data sources and picked the Health, Nutrition, and Population (HNP) dataset from the World Bank open data repository. The dataset provides key health, nutrition, and population statistics gathered from various international and national sources. The data was downloaded as a filtered CSV file with African countries and 23 indicators relating to workforce, infrastructure, and financing are the focus. Some of the indicators used are
Current health expenditure (% of GDP), Current health expenditure per capita (current US$), Domestic general government health expenditure (% of GDP), Domestic private health expenditure (% of current health expenditure), External health expenditure per capita (current US$), etc
I created a legend .csv file that provides a detailed explanation of the indicators (series name) used, their corresponding series code, and series description and can be found in my GitHub repository along with other relevant data here

### Data Cleaning: 
I cleaned the data using Google Sheets. I checked for duplicates, used the TRIM function to remove trailing or leading spaces, used spell check, and created a filter to check for blanks which revealed null values for some countries and series codes. The records of countries with missing values for the entire time series were deleted. The cleaned .csv file contained 1242 rows and 11 columns.

### SQL: 
The cleaned dataset was uploaded to MS SQL Server Management Studio, and a ```Healthcare_WorldBank``` database was created from the Object Explorer section of SQL Server Management Studio. A ```WorldBankData``` table was created inside the ```Healthcare_WorldBank``` database. SQL was used to analyze the dataset. Queries were run to see if the data was properly imported, count the number of rows to see if it was complete, round the fields containing float data to the nearest 2 decimal places, and created a #wbd temp table for my session

![query_1](https://user-images.githubusercontent.com/113455719/234799414-1214df8b-648d-49dc-acc3-12228275446c.png)

![query_2](https://user-images.githubusercontent.com/113455719/234799514-cf871a74-b04a-41a9-a8dc-07387b35bb9f.png)


### Analysis: 
I used SQL queries to answer questions about the healthcare industry in Africa. I analyzed how much African countries spend on health, the countries with the highest current health expenditure in each year, the countries with the lowest current health expenditure in each year, the countries that are the heaviest spenders per capita and per capita at purchasing power parity, and the countries with the highest and lowest health expenditure per capita. The results were presented in tables through SQL.
