SELECT gender, count(*) AS Count_Gender
FROM cleaneddata.customers
GROUP BY gender;

-- Age bucketing
SELECT
    age_bucket,
    COUNT(*) AS count
FROM (
    SELECT
        *,
        CASE
            WHEN age <= 18 THEN '<=18'
            WHEN age BETWEEN 18 AND 25 THEN '18-25'
            WHEN age BETWEEN 25 AND 35 THEN '25-35'
            WHEN age BETWEEN 35 AND 45 THEN '35-45'
            WHEN age BETWEEN 45 AND 55 THEN '45-55'
            WHEN age BETWEEN 55 AND 65 THEN '55-65'
            ELSE '>65'
        END AS age_bucket
    FROM (
        SELECT 
            *,
            YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) AS age
        FROM cleaneddata.overall
        WHERE Order_date IS NOT NULL AND birthday IS NOT NULL  -- Ensures no NULL values
    ) AS calculated_ages
) AS age_groups
GROUP BY age_bucket;


-- countery wise customer count
SELECT 
    continent,country,state,city, 
    COUNT(CustomerKey) AS customer_count
FROM 
    cleaneddata.customers
GROUP BY 
    continent,country,state,city
ORDER BY 
    customer_count DESC