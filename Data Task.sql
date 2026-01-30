CREATE DATABASE data;
USE data;

SHOW TABLES;
SELECT * FROM data_updated;

SELECT COUNT(*) FROM data_updated;

-- first 10 rows for verification
SELECT * FROM data_updated
LIMIT 10;

-- distinct values exist for each key category
SELECT  
    COUNT(DISTINCT ym) AS unique_periods,
    COUNT(DISTINCT exp_imp) AS trade_type_count,
    COUNT(DISTINCT country) AS unique_countries,
    COUNT(DISTINCT customs) AS unique_customs,
    COUNT(DISTINCT hs9_HS_code) AS unique_hs_codes
FROM data_updated;


-- the monthly total trade value
SELECT ym, SUM(Value) AS monthly_trade_value
FROM data_updated
GROUP BY ym
ORDER BY ym;


-- HS codes contribute the highest value (Top 10 HS codes)
SELECT hs9_HS_code, SUM(Value) AS total_value
FROM data_updated
GROUP BY hs9_HS_code
ORDER BY total_value DESC
LIMIT 10;


-- countries have the highest total trade value (Top 10 countries)
SELECT country, SUM(Value) AS total_value
FROM data_updated
GROUP BY country
ORDER BY total_value DESC
LIMIT 10;


-- customs locations handled the most value (Top 10 customs codes)
SELECT customs, SUM(Value) AS total_value
FROM data_updated
GROUP BY customs
ORDER BY total_value DESC LIMIT 10;

-- the total quantity traded per month
SELECT ym,SUM(Q1) AS total_Q1, SUM(Q2) AS total_Q2
FROM data_updated
GROUP BY ym
ORDER BY ym;

-- HS codes have the highest total quantity traded
SELECT hs9_HS_code, SUM(Q1 + Q2) AS total_quantity
FROM data_updated
GROUP BY hs9_HS_code
ORDER BY total_quantity DESC
LIMIT 10;


-- country trades , which HS code the most (HS-wise country comparison)

SELECT country, hs9_HS_code, SUM(Value) AS total_value
FROM data_updated
GROUP BY country, hs9_HS_code
ORDER BY total_value DESC
LIMIT 20;

-- Percentage contribution of each country in total trade

SELECT country, SUM(Value) AS country_value, 
(SUM(Value) * 100.0 / (SELECT SUM(Value) FROM data_updated)) AS percentage
FROM data_updated
GROUP BY country
ORDER BY country_value DESC;

-- rows with zero quantity but positive value (data quality check)

SELECT * FROM data_updated
WHERE (Q1 = 0 AND Q2 = 0) AND Value > 0;


-- Monthly value vs quantity comparison

SELECT ym,
    SUM(Value) AS total_value,
    SUM(Q1 + Q2) AS total_quantity
FROM data_updated
GROUP BY ym
ORDER BY ym;




