-- sales analysis

SELECT
  MONTHNAME(order_date) AS month_year,
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  cleaneddata.overall
GROUP BY
  MONTHNAME(order_date);
  
  -- sales by top product performance
  
SELECT
	product_name,
    SUM(quantity) AS total_quantity
FROM
	cleaneddata.overall
GROUP BY
	product_name
ORDER BY total_quantity DESC
limit 10;

-- sales by revenue performance

SELECT 
	product_name,
    ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
	cleaneddata.overall
GROUP BY
	product_name
ORDER BY total_revenue_USD DESC
limit 10;

-- sales by stores
SELECT 
	storekey,
    ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
	cleaneddata.overall
GROUP BY
	storekey
ORDER BY total_revenue_USD DESC
limit 10;