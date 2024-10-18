-- size bucket vs total_sales
SELECT
    CASE
        WHEN square_meters < 250 THEN '<250'
        WHEN square_meters BETWEEN 250 AND 500 THEN '250 to 500'
        WHEN square_meters BETWEEN 501 AND 750 THEN '500 to 750'
        WHEN square_meters BETWEEN 751 AND 1000 THEN '750 to 1000'
        WHEN square_meters BETWEEN 1001 AND 1250 THEN '1000 to 1250'
        WHEN square_meters BETWEEN 1251 AND 1500 THEN '1250 to 1500'
        WHEN square_meters BETWEEN 1501 AND 1750 THEN '1500 to 1750'
        WHEN square_meters BETWEEN 1751 AND 2000 THEN '1750 to 2000'
        WHEN square_meters > 2000 THEN '>2000'
    END AS bucket_size,
    ROUND(SUM(unit_price_usd * quantity), 2) AS total_sales
FROM cleaneddata.overall
GROUP BY bucket_size
ORDER BY 
    MIN(square_meters);
    
    -- store_age_bucket vs total sales
SELECT
    CASE
        WHEN YEAR(CURDATE()) - YEAR(open_date) <= 5 THEN '<=5'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 6 AND 10 THEN '6 to 10'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 11 AND 15 THEN '11 to 15'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 16 AND 20 THEN '16 to 20'
        ELSE '>20'
    END AS store_age_bucket,
    ROUND(SUM(unit_price_usd * quantity), 2) AS total_sales
FROM cleaneddata.overall
GROUP BY store_age_bucket
ORDER BY 
    CASE
        WHEN store_age_bucket = '<=5' THEN 1
        WHEN store_age_bucket = '6 to 10' THEN 2
        WHEN store_age_bucket = '11 to 15' THEN 3
        WHEN store_age_bucket = '16 to 20' THEN 4
        WHEN store_age_bucket = '>20' THEN 5
    END;
    
-- Storekey vs Country vs Continent vs State
SELECT
  storekey,Country,Continent,State,
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  cleaneddata.overall
GROUP BY
  storekey,Country,Continent,State
order by total_revenue_USD desc