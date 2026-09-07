WITH duplicates AS (
    SELECT 
        LOWER(brand_description) AS brand_description_lower,
        COUNT(*) AS occurrence_count,
        ARRAY_AGG(brand_id ORDER BY brand_id) AS brand_ids,
        ARRAY_AGG(brand_description ORDER BY brand_id) AS brand_descriptions
    FROM {{ ref('staging_brands') }}
    GROUP BY LOWER(brand_description)
    HAVING COUNT(*) > 1
)

SELECT 
    brand_description_lower,
    occurrence_count,
    brand_ids,
    brand_descriptions
FROM duplicates