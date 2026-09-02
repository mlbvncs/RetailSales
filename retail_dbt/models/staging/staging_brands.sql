WITH source_brands AS (
    SELECT * 
    FROM {{ source('raw', 'brands') }}
),

cleaned_brands AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS brand_id,
        INITCAP(TRIM(REGEXP_REPLACE(brand_description, '\s+', ' ', 'g'))) AS brand_description
    FROM source_brands
    WHERE brand_description IS NOT NULL AND brand_description <> ''
),

deduplicated_brand_description AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY LOWER(brand_description)
            ORDER BY brand_id ASC
        ) AS row_rank
    FROM cleaned_brands
)

SELECT
    brand_id,
    brand_description
FROM deduplicated_brand_description
WHERE row_rank = 1