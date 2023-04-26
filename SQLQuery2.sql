-- Check to see if dataset is imported properly
SELECT *
FROM Healthcare_WorldBank.dbo.WorldBankData

-- Count the number of rows 
SELECT COUNT(country_name) AS num_of_rows
FROM Healthcare_WorldBank.dbo.WorldBankData

-- Round to 2 decimal places
SELECT 
country_name, 
country_code, 
series_code, 
ROUND (yr_2015, 2) AS yr_2015, 
ROUND (yr_2016, 2) AS yr_2016, 
ROUND (yr_2017, 2) AS yr_2017, 
ROUND (yr_2018, 2) AS yr_2018, 
ROUND (yr_2019, 2) AS yr_2019
FROM Healthcare_WorldBank.dbo.WorldBankData

-- Create temp table and round to 2 decimals
CREATE TABLE #wbd
(
    country_name VARCHAR(255),
    country_code VARCHAR(255),
    series_code VARCHAR(255),
    yr_2015 DECIMAL(18,2),
	yr_2016 DECIMAL(18,2),
    yr_2017 DECIMAL(18,2),
	yr_2018 DECIMAL(18,2),
	yr_2019 DECIMAL(18,2)
);
INSERT INTO #wbd
SELECT country_name, country_code, series_code, yr_2015, yr_2016, yr_2017, yr_2018, yr_2019
FROM Healthcare_WorldBank.dbo.WorldBankData

-- Check how many % of GDP African countries spend on health
SELECT *
FROM #wbd
WHERE series_code = 'CHE' ---CHE is % of GDP

-- African countries with highest current health expenditure by year
SELECT 
country_name, 
yr_2015, 
RANK() OVER (ORDER BY yr_2015 DESC) as rk_2015, 
yr_2016, 
RANK() OVER (ORDER BY yr_2016 DESC) as rk_2016,
yr_2017,
RANK() OVER (ORDER BY yr_2017 DESC) as rk_2017,
yr_2018,
RANK() OVER (ORDER BY yr_2018 DESC) as rk_2018,
yr_2019,
RANK() OVER (ORDER BY yr_2019 DESC) as rk_2019
FROM #wbd
WHERE series_code = 'CHE' 
ORDER BY 3

-- African countries with lowest current health expenditure by year

SELECT 
country_name, 
yr_2015, 
RANK() OVER (ORDER BY yr_2015 DESC) as rk_2015, 
yr_2016, 
RANK() OVER (ORDER BY yr_2016 DESC) as rk_2016,
yr_2017,
RANK() OVER (ORDER BY yr_2017 DESC) as rk_2017,
yr_2018,
RANK() OVER (ORDER BY yr_2018 DESC) as rk_2018,
yr_2019,
RANK() OVER (ORDER BY yr_2019 DESC) as rk_2019
FROM #wbd
WHERE series_code = 'CHE' 
ORDER BY 3 DESC

-- Current Health Expenditure per capita and per capita at purchase price parity
SELECT *
FROM #wbd
WHERE series_code IN ('CHE_CAP', 'CHE_CAP_PPP') --- Health expenditure per capita & per capita at purchasing power parity
AND country_name IN ('Sierra Leone', 'Malawi', 'Central African Republic', 'Lesotho', 'Congo, Rep.', 'Angola')
ORDER BY 1, 3

-- Top 5 Current Health Expenditure per capita
SELECT TOP 5
country_name, 
yr_2015, RANK() OVER (ORDER BY yr_2015 DESC) AS rk_2015, 
yr_2016, RANK() OVER (ORDER BY yr_2016 DESC) AS rk_2016,
yr_2017, RANK() OVER (ORDER BY yr_2017 DESC) AS rk_2017,
yr_2018, RANK() OVER (ORDER BY yr_2018 DESC) AS rk_2018,
yr_2019, RANK() OVER (ORDER BY yr_2019 DESC) AS rk_2019
FROM #wbd
WHERE series_code = 'CHE_CAP' 
ORDER BY 10 DESC

-- To transform data from long to wide using UNPIVOT & PIVOT
SELECT *
FROM (
  SELECT country_name, country_code, series_code, yr_2015 AS [2015], yr_2016 AS [2016], yr_2017 AS [2017], yr_2018 AS [2018], yr_2019 AS [2019]
  FROM #wbd
) AS SourceTable
UNPIVOT (
  Value FOR year IN ([2015], [2016], [2017], [2018], [2019])
) AS UnpivotTable
PIVOT (
  MAX(Value) FOR series_code IN (CHE, CAPHE, CHE_CAP, CHE_CAP_PPP, GGHED_CHE, GGHED, GGHED_GGE, GGHED_CAP, GGHED_CAP_PPP, PVTD_CHE, PVTD_CAP, PVTD_CAP_PPP, EXT_EHE, EXT_CHE, EXT_CAP, EXT_CAP_PPP, OOP_CHE, OOP_CAP, OOP_CAP_PPP, HBD, UHC_SCI)
) AS PivotTable

-- Average current health expenditure per capita & per capita at purchase price parity
WITH avgtable AS (
SELECT *
FROM (
  SELECT country_name, country_code, series_code, yr_2015 AS [2015], yr_2016 AS [2016], yr_2017 AS [2017], yr_2018 AS [2018], yr_2019 AS [2019]
  FROM #wbd
) AS SourceTable
UNPIVOT (
  Value FOR year IN ([2015], [2016], [2017], [2018], [2019])
) AS UnpivotTable
PIVOT (
  MAX(Value) FOR series_code IN (CHE, CAPHE, CHE_CAP, CHE_CAP_PPP, GGHED_CHE, GGHED, GGHED_GGE, GGHED_CAP, GGHED_CAP_PPP, PVTD_CHE, PVTD_CAP, PVTD_CAP_PPP, EXT_EHE, EXT_CHE, EXT_CAP, EXT_CAP_PPP, OOP_CHE, OOP_CAP, OOP_CAP_PPP, HBD, UHC_SCI)
) AS PivotTable
)
SELECT country_name, CAST (AVG(CHE_CAP) AS DECIMAL (25,2)) AS avg_cap_che, CAST (AVG(CHE_CAP_PPP) AS DECIMAL (25,2)) AS avg_che_cap_ppp
FROM avgtable
GROUP BY country_name
HAVING country_name IN ('Seychelles', 'Mauritius', 'South Africa', 'Namibia', 'Botswana')

-- current health expenditure of top 5
SELECT *
FROM #wbd
WHERE country_name IN ('Seychelles', 'Mauritius', 'South Africa', 'Namibia', 'Botswana')
AND series_code = 'CHE'

-- bottom 5 current health expenditure per capita and their occurences between 2015-2019
WITH sumtable AS (
SELECT TOP 10
country_name, 
yr_2015, RANK() OVER (ORDER BY yr_2015) AS rk_2015, 
yr_2016, RANK() OVER (ORDER BY yr_2016) AS rk_2016,
yr_2017, RANK() OVER (ORDER BY yr_2017) AS rk_2017,
yr_2018, RANK() OVER (ORDER BY yr_2018) AS rk_2018,
yr_2019, RANK() OVER (ORDER BY yr_2019) AS rk_2019
FROM #wbd
WHERE series_code = 'CHE_CAP' 
ORDER BY yr_2016
)
SELECT 
country_name, 
(CASE WHEN rk_2015 <= 5 THEN 1 ELSE 0 END + CASE WHEN rk_2016 <= 5 THEN 1 ELSE 0 END + 
CASE WHEN rk_2017 <= 5 THEN 1 ELSE 0 END +  CASE WHEN rk_2018 <= 5 THEN 1 ELSE 0 END + 
CASE WHEN rk_2019 <= 5 THEN 1 ELSE 0 END) AS total_end5
FROM sumtable
ORDER BY 2 DESC

-- Check Current health expenditure, domestic government health expenditure, private health expenditure & external health expenditure.
SELECT *
FROM #wbd
WHERE series_code IN ('CHE', 'GGHED_CHE', 'PVTD_CHE', 'EXT_CHE')
ORDER BY 1, 3

-- create #hedist temp table, transform data from long to wide 
WITH cte AS (
SELECT *
FROM (
  SELECT country_name, country_code, series_code, yr_2015 AS [2015], yr_2016 AS [2016], yr_2017 AS [2017], yr_2018 AS [2018], yr_2019 AS [2019]
  FROM #wbd
) AS SourceTable
UNPIVOT (
  Value FOR year IN ([2015], [2016], [2017], [2018], [2019])
) AS UnpivotTable
PIVOT (
  MAX(Value) FOR series_code IN (CHE, GGHED_CHE, PVTD_CHE, EXT_CHE)
) AS PivotTable
), cte2 AS (
SELECT country_name, year, CHE, GGHED_CHE, PVTD_CHE, EXT_CHE, (GGHED_CHE + PVTD_CHE + EXT_CHE) AS TOTAL, 
CASE WHEN GGHED_CHE > PVTD_CHE AND GGHED_CHE > EXT_CHE THEN 'Government'
WHEN PVTD_CHE > GGHED_CHE AND PVTD_CHE > EXT_CHE THEN 'Private'
WHEN EXT_CHE > GGHED_CHE AND EXT_CHE > PVTD_CHE THEN 'External'
ELSE 'Equal' END AS INFO
FROM cte
)
SELECT * 
INTO #hedist
FROM cte2

-- yearly distribution of private, government & external health expenditure
SELECT year, 
COUNT (CASE WHEN INFO = 'Government' THEN 1 END) AS govt_health_expd,
COUNT (CASE WHEN INFO = 'Private' THEN 1 END) AS private_health_expd,
COUNT (CASE WHEN INFO = 'External' THEN 1 END) AS ext_health_expd
FROM #hedist
GROUP BY year

-- top yearly domestic private funding countries
WITH cte AS (
SELECT *, 
ROW_NUMBER () OVER (PARTITION BY year ORDER BY PVTD_CHE DESC) AS position
FROM #hedist
WHERE INFO = 'Private'
)
SELECT country_name, year, PVTD_CHE, GGHED_CHE, EXT_CHE
FROM cte
WHERE position = 1

-- top yearly government funding countries
WITH cte AS (
SELECT *, 
ROW_NUMBER () OVER (PARTITION BY year ORDER BY GGHED_CHE DESC) AS position
FROM #hedist
WHERE INFO = 'Government'
)
SELECT country_name, year, GGHED_CHE, PVTD_CHE, EXT_CHE
FROM cte
WHERE position = 1

-- top yearly external funding countries
WITH cte AS (
SELECT *, 
ROW_NUMBER () OVER (PARTITION BY year ORDER BY EXT_CHE DESC) AS position
FROM #hedist
WHERE INFO = 'External'
)
SELECT country_name, year, EXT_CHE, GGHED_CHE, PVTD_CHE
FROM cte
WHERE position = 1

-- create #OOP temp table and transform data from long to wide
SELECT *
INTO #OOP
FROM (
  SELECT country_name, country_code, series_code, yr_2015 AS [2015], yr_2016 AS [2016], yr_2017 AS [2017], yr_2018 AS [2018], yr_2019 AS [2019]
  FROM #wbd
) AS SourceTable
UNPIVOT (
  Value FOR year IN ([2015], [2016], [2017], [2018], [2019])
) AS UnpivotTable
PIVOT (
  MAX(Value) FOR series_code IN (OOP_CHE, OOP_CAP, OOP_CAP_PPP)
) AS PivotTable

-- highest yearly out of pocket expenditure
WITH cte AS (
SELECT country_name, year, OOP_CHE,
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CHE DESC) AS RNK, 
OOP_CAP,
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CAP DESC) AS RNK2,
OOP_CAP_PPP, 
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CAP_PPP DESC) AS RNK3
FROM #OOP
)
SELECT *
FROM cte
WHERE RNK = 1

-- lowest yearly out of pocket expenditure
WITH cte AS (
SELECT country_name, year, OOP_CHE,
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CHE) AS RNK, 
OOP_CAP,
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CAP) AS RNK2,
OOP_CAP_PPP, 
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CAP_PPP) AS RNK3
FROM #OOP
WHERE OOP_CHE IS NOT NULL
)
SELECT *
FROM cte
WHERE RNK = 1

-- bottom yearly out of pocket expenditure per capita
WITH cte AS (
SELECT country_name, year, OOP_CHE,
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CHE) AS RNK, 
OOP_CAP,
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CAP) AS RNK2,
OOP_CAP_PPP, 
DENSE_RANK() OVER(PARTITION BY year ORDER BY OOP_CAP_PPP) AS RNK3
FROM #OOP
WHERE OOP_CHE IS NOT NULL
)
SELECT *
FROM cte
WHERE RNK2 = 1

-- average out of pocket per capita & per capita at purchase price parity
SELECT country_name,
CAST(AVG(OOP_CAP) AS DECIMAL (18,2)) AS avg_oop_cap,
CAST(AVG(OOP_CAP_PPP) AS DECIMAL (18,2)) AS avg_oop_cap_ppp
FROM #OOP
GROUP BY country_name
HAVING country_name IN ('Botswana', 'Equatorial Guinea', 'Malawi', 'Mauritius', 'Mozambique', 'Nigeria')
ORDER BY 1

-- create #growth temp table
WITH cte AS (
SELECT country_name, year, CHE, CHE_CAP, GGHED_CHE, PVTD_CHE, EXT_CHE, OOP_CHE, OOP_CAP, LE_BTH, IMRT_IN
FROM (
  SELECT country_name, country_code, series_code, yr_2015 AS [2015], yr_2016 AS [2016], yr_2017 AS [2017], yr_2018 AS [2018], yr_2019 AS [2019]
  FROM #wbd
) AS SourceTable
UNPIVOT (
  Value FOR year IN ([2015], [2016], [2017], [2018], [2019])
) AS UnpivotTable
PIVOT (
  MAX(Value) FOR series_code IN (CHE, CHE_CAP, CHE_CAP_PPP, GGHED_CHE, PVTD_CHE, EXT_CHE, OOP_CHE, OOP_CAP, OOP_CAP_PPP, LE_BTH, IMRT_IN)
) AS PivotTable
)
SELECT *
INTO #growth
FROM cte

-- year on year growth 
SELECT 
country_name, 
year, 
CHE, 
CHE - LAG(CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff, 
GGHED_CHE, 
GGHED_CHE - LAG(GGHED_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff2, 
PVTD_CHE, 
PVTD_CHE - LAG(PVTD_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff3, 
EXT_CHE, 
EXT_CHE - LAG(EXT_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff4, 
OOP_CHE, 
OOP_CHE - LAG(OOP_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff5 
FROM #growth

-- Using CASE to confirm growth rate
WITH growth_table AS (
SELECT 
country_name, 
year, 
CHE, 
CHE - LAG(CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff, 
GGHED_CHE, 
GGHED_CHE - LAG(GGHED_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff2, 
PVTD_CHE, 
PVTD_CHE - LAG(PVTD_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff3, 
EXT_CHE, 
EXT_CHE - LAG(EXT_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff4, 
OOP_CHE, 
OOP_CHE - LAG(OOP_CHE) OVER (PARTITION BY country_name ORDER BY year) AS diff5 
FROM #growth
)
SELECT 
country_name,
CASE 
WHEN MIN(diff) >= 0 AND MAX(diff) >= 0 THEN 'Yearly Growth'
WHEN MIN(diff) <= 0 AND MAX(diff) <= 0 THEN 'Yearly Decline'
ELSE 'Mixed'
END AS growth_status
FROM growth_table
GROUP BY country_name
ORDER BY growth_status DESC

-- infant mortality rate & life expentancy at birth
SELECT 
country_name, 
year, 
CAST(LE_BTH AS INT) AS LE_BTH, 
CAST(LE_BTH AS INT) - CAST(LAG(LE_BTH) OVER (PARTITION BY country_name ORDER BY year) AS INT) AS diff1,
CAST(IMRT_IN AS INT) AS IMRT_IN,
CAST(IMRT_IN AS INT) - CAST(LAG(IMRT_IN) OVER (PARTITION BY country_name ORDER BY year) AS INT) AS diff2
FROM #growth
WHERE 
country_name IN ('Angola' ,'Botswana' ,'Burundi' ,'Central African Republic' ,'Congo, Dem. Rep.' ,'Congo, Rep.' ,'Equatorial Guinea' ,'Eritrea' ,'Ethiopia' ,'Gambia' ,'Lesotho' ,'Madagascar' ,'Malawi' ,'Mauritius' ,'Mozambique' ,'Namibia' ,'Niger' ,'Nigeria' ,'Sao Tome & Principe' ,'Seychelles' ,'Sierra Leone' ,'South Africa' ,'Sudan' ,'Tanzania' ,'Zambia')
ORDER BY 1

-- max life expentancy at birth and its corresponding year
SELECT g.country_name, CAST(g.LE_BTH AS numeric) as max_life_expect, g.year
FROM #growth g
JOIN (
    SELECT country_name, MAX(LE_BTH) AS max_LE_BTH
    FROM #growth
    GROUP BY country_name
) sub
ON g.country_name = sub.country_name AND g.LE_BTH = sub.max_LE_BTH
WHERE g.country_name IN ('Angola' ,'Botswana' ,'Burundi' ,'Central African Republic' ,'Congo, Dem. Rep.' ,'Congo, Rep.' ,'Equatorial Guinea' ,'Eritrea' ,'Ethiopia' ,'Gambia' ,'Lesotho' ,'Madagascar' ,'Malawi' ,'Mauritius' ,'Mozambique' ,'Namibia' ,'Niger' ,'Nigeria' ,'Sao Tome & Principe' ,'Seychelles' ,'Sierra Leone' ,'South Africa' ,'Sudan' ,'Tanzania' ,'Zambia')
ORDER BY 2 DESC

-- min life expectancy at birth
SELECT g.country_name, CAST(g.LE_BTH AS numeric) as min_life_expect, g.year
FROM #growth g
JOIN (
    SELECT country_name, MIN(LE_BTH) AS min_LE_BTH
    FROM #growth
    GROUP BY country_name
) sub
ON g.country_name = sub.country_name AND g.LE_BTH = sub.min_LE_BTH
WHERE g.country_name IN ('Angola' ,'Botswana' ,'Burundi' ,'Central African Republic' ,'Congo, Dem. Rep.' ,'Congo, Rep.' ,'Equatorial Guinea' ,'Eritrea' ,'Ethiopia' ,'Gambia' ,'Lesotho' ,'Madagascar' ,'Malawi' ,'Mauritius' ,'Mozambique' ,'Namibia' ,'Niger' ,'Nigeria' ,'Sao Tome & Principe' ,'Seychelles' ,'Sierra Leone' ,'South Africa' ,'Sudan' ,'Tanzania' ,'Zambia')
ORDER BY 2

-- highest infant mortality rate and its corresponding year
SELECT g.country_name, g.IMRT_IN as max_IMRT_IN, g.year
FROM #growth g
JOIN (
    SELECT country_name, MAX(IMRT_IN) AS IMRT_IN
    FROM #growth
    GROUP BY country_name
) sub
ON g.country_name = sub.country_name AND g.IMRT_IN = sub.IMRT_IN
WHERE g.country_name IN ('Angola' ,'Botswana' ,'Burundi' ,'Central African Republic' ,'Congo, Dem. Rep.' ,'Congo, Rep.' ,'Equatorial Guinea' ,'Eritrea' ,'Ethiopia' ,'Gambia' ,'Lesotho' ,'Madagascar' ,'Malawi' ,'Mauritius' ,'Mozambique' ,'Namibia' ,'Niger' ,'Nigeria' ,'Sao Tome & Principe' ,'Seychelles' ,'Sierra Leone' ,'South Africa' ,'Sudan' ,'Tanzania' ,'Zambia')
ORDER BY 2 DESC

-- lowest infant mortality rate and its corresponding year
SELECT g.country_name, g.IMRT_IN as min_IMRT_IN, g.year
FROM #growth g
JOIN (
    SELECT country_name, MIN(IMRT_IN) AS IMRT_IN
    FROM #growth
    GROUP BY country_name
) sub
ON g.country_name = sub.country_name AND g.IMRT_IN = sub.IMRT_IN
WHERE g.country_name IN ('Angola' ,'Botswana' ,'Burundi' ,'Central African Republic' ,'Congo, Dem. Rep.' ,'Congo, Rep.' ,'Equatorial Guinea' ,'Eritrea' ,'Ethiopia' ,'Gambia' ,'Lesotho' ,'Madagascar' ,'Malawi' ,'Mauritius' ,'Mozambique' ,'Namibia' ,'Niger' ,'Nigeria' ,'Sao Tome & Principe' ,'Seychelles' ,'Sierra Leone' ,'South Africa' ,'Sudan' ,'Tanzania' ,'Zambia')
ORDER BY 2
