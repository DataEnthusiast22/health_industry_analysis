# Healthcare Finance & Development in Africa (2015–2019): A SQL ANALYSIS

From 2015 to 2019, healthcare development and financing in African countries were a topic of significant concern. Many countries on the continent face significant challenges in providing adequate healthcare services to their citizens due to a lack of funding, inadequate infrastructure, and poor management practices. As a result, healthcare outcomes in many African countries lagged behind those of developed nations.
This project aims to analyze the state of healthcare development and financing in selected African countries between 2015 and 2019, with a particular focus on understanding the factors that contribute to disparities in healthcare outcomes. Through this analysis, I hope to answer the question: What was the state of healthcare development in these countries during the period under review? 
This analysis sought to gain a deeper understanding of the challenges and opportunities in the healthcare sector in Africa. Ultimately, to provide insights that can inform policies and initiatives aimed at improving healthcare outcomes and reducing disparities in the region.

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

At the bottom of the table in terms of current health expenditure as a percentage of GDP, the countries occupying the 5 least positions within the time period were Congo Dem. Rep & Burundi appeared the most followed by Eritrea, Madagascar, Ethiopia, Central African Republic, Niger, Gambia & Sudan.

![query_12](https://user-images.githubusercontent.com/113455719/234801629-8737100f-4e7f-4290-8ae6-a250ecbac5fc.png)

![result_2](https://user-images.githubusercontent.com/113455719/234801865-30f866cd-8977-4447-891e-490b0227c588.png)

NOTE: It was at this point, I discovered Intellisense and turned off those pesky redlines that see column names & table names as errors. :) Thanks _Matt Monfils of LinkedIn 'Tips & Tricks - Disabling the Spell Checker Tool in Microsoft SQL Server'_

### 2. How is health expenditure distributed between government and private sectors in African countries?

To investigate how health expenditure is distributed between the government and private sectors in African countries, I used three indicators: Domestic general government health expenditure (% of current health expenditure), Domestic private health expenditure (% of current health expenditure), and External health expenditure (% of current health expenditure). I also checked that the total of all indicators was not greater than 100% and identified the yearly greatest contributors to health expenditure. To do this, I created another temporary table ```#hedist``` using nested CTEs and transformed the data structure from long to wide.

![query_14](https://user-images.githubusercontent.com/113455719/234803328-56647c6e-f4e0-4957-8691-5fe1312c0711.png)

![result_3](https://user-images.githubusercontent.com/113455719/234803346-d21a89d5-26d8-4d00-b96d-432bbec24c3e.png)

According to the results below, the greatest contributors to health expenditure in Africa were from the domestic private sector.

![query_15](https://user-images.githubusercontent.com/113455719/234803481-e5808e7e-0f36-4b87-9e4a-c1ba7103d8b2.png)

Cameroon (2015–2019) had the highest percentage of domestic private funding towards health.

![new_query_private](https://user-images.githubusercontent.com/113455719/234803683-010b4c33-0557-408e-9297-b9f356452cf6.png)

On the other hand, Seychelles (2015, 2016) and Botswana (2017, 2018, 2019) were the countries with the highest domestic government funding towards health expenditure.

![new_query_govt](https://user-images.githubusercontent.com/113455719/234803829-300afbc7-c6ab-4a06-968e-f9d31d9805bb.png)

Lastly, Mozambique (2015, 2016, 2019) & South Sudan (2017, 2018) were countries that had the highest external funding expenditure towards health expenditure.

![new_query_ext](https://user-images.githubusercontent.com/113455719/234803868-e4f3e66b-0666-4e66-ab13-421c0ad95348.png)

### 3. How much do individuals pay out of pocket for healthcare in African countries?

I created another  temp table ```#OOP``` in wide format to examine Out-of-pocket expenditure (OOP) using the indicators OOP_CHE, OOP_CAP, and OOP_CAP_PPP.

![query_18](https://user-images.githubusercontent.com/113455719/234804260-bc35583a-4065-4fbf-a205-b24b55695d93.png)

The data shows that Out-of-pocket expenditure (as a percentage of current health expenditure) accounted for a significant portion of total health expenditure in Nigeria and Equatorial Guinea, ranging from 75% to 77%. This indicates a limited reach of government-sponsored health programs/payment schemes. Botswana had the lowest OOP as a percentage of total health expenditure within the time period.

![query_19](https://user-images.githubusercontent.com/113455719/234804274-3aa64c83-69f4-441f-a2c3-0254f07b7008.png)

![query_20](https://user-images.githubusercontent.com/113455719/234804473-62632b0c-d9ec-4a57-8005-d035ff660cf3.png)

Mauritius has the highest OOP per capita and per capita at purchasing price parity. Malawi and Mozambique had the lowest OOP per capita at purchasing price parity.

![result_5](https://user-images.githubusercontent.com/113455719/234804741-91c3c072-a141-4af3-8a8e-09dc6f71d627.png)

![result_6](https://user-images.githubusercontent.com/113455719/234804749-5c6fca91-988a-4d19-91b8-68763aa40342.png)

The table below shows the Out-of-pocket expenditure per capita and per capita at purchase price parity averages of the countries mentioned above:

![table_1](https://user-images.githubusercontent.com/113455719/234805335-85d20720-4dbd-4268-8f6a-9e62131a635f.png)

I created another temp table ```#growth``` to examine the annual growth rate of all indicators to identify a pattern.

![query_21](https://user-images.githubusercontent.com/113455719/234805622-daf25c23-4028-4e3e-9263-8704a6e8a789.png)

Using the CASE statement, I confirmed that only Mauritius had a year-on-year increase in health expenditure, indicating a positive mindset towards healthcare financing, while Djibouti, Liberia, Benin, Ethiopia, and South Sudan had a year-on-year decrease in health expenditure.

![query_22](https://user-images.githubusercontent.com/113455719/234805807-ec072573-f8bf-4356-999c-7f136154a03d.png)

![result_7](https://user-images.githubusercontent.com/113455719/234805900-5a182ab7-a011-4423-bd07-ab1c0218eda0.png)

## CONCLUSION

1. African countries face significant challenges in financing their healthcare systems, including inadequate public funding, high out-of-pocket expenses for patients, and limited access to international aid.
2. Many African countries have made progress in improving their healthcare systems in recent years, but more needs to be done to address disparities in access to care and health outcomes across different regions and populations.
3. Strategies to improve healthcare financing in African countries may include increasing government spending on healthcare, promoting private sector investment, improving tax collection, and reducing waste and corruption.
4. Innovative approaches to healthcare financing and service delivery, such as telemedicine, mobile health, and community-based health insurance schemes, may help to overcome some of the challenges faced by African countries in improving access to quality healthcare.
