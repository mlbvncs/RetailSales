SELECT LOWER(brand_description) AS brand_description_lower, COUNT(*) AS qtd
FROM {{ ref('staging_brands') }}
GROUP BY LOWER(brand_description)
HAVING COUNT(*) > 1