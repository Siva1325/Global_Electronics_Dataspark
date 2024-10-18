-- Catagory and sub catagory analysis
SELECT
    category,subcategory,
    ROUND(SUM(unit_price_usd * quantity),2) AS total_sales
FROM cleaneddata.overall
GROUP BY category,subcategory
ORDER BY total_sales DESC;

-- Product Popularity: Identify the most and least popular products based on sales data.

(SELECT 
	product_name, 
    SUM(quantity) AS Quantity,
    'Most Popular' AS popularity_label
from cleaneddata.overall
group by product_name
order by Quantity desc
limit 10)

UNION ALL

(SELECT 
	product_name, 
    SUM(quantity) AS Quantity,
    'Least Popular' AS popularity_label
from cleaneddata.overall
group by product_name
order by Quantity 
limit 10);

-- Profitability Analysis: Calculate profit margins for products by comparingunit cost and unit price.
SELECT
    product_name,
    ROUND(SUM((unit_price_usd - unit_cost_usd) * quantity), 2) AS Profit_Margin
FROM cleaneddata.overall
GROUP BY product_name
ORDER BY Profit_Margin DESC
LIMIT 10;