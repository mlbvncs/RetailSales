WITH duplicates AS (
    SELECT 
        LOWER(region_name) AS lower_region_name,
        COUNT(*) AS occurrence_count,
        ARRAY_AGG(region_id ORDER BY region_id) AS region_ids,
        ARRAY_AGG(region_name ORDER BY region_id) AS region_names
    FROM {{ ref('staging_regions') }}
    GROUP BY LOWER(region_name)
    HAVING COUNT(*) > 1
)

SELECT 
    lower_region_name,
    occurrence_count,
    region_ids,
    region_names
FROM duplicates