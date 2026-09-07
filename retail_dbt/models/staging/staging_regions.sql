WITH source_regions AS (
    SELECT 
        *,
        ROW_NUMBER() OVER () AS source_row_num
    FROM {{ source('raw', 'regions') }}
),

null_removed AS (
    SELECT *
    FROM source_regions
    WHERE region_id IS NOT NULL AND TRIM(region_id) <> ''
        AND region_name IS NOT NULL AND TRIM(region_name) <> ''
),

format_validated AS (
    SELECT *
    FROM null_removed
    WHERE TRIM(region_id) ~ '^[0-9]+$' AND CAST(TRIM(region_id) AS INTEGER) > 0
),

cleaned_regions AS (
    SELECT
        source_row_num,
        CAST(TRIM(region_id) AS INTEGER) AS region_id,
        INITCAP(TRIM(region_name)) AS region_name
    FROM format_validated
),

deduplicated_region_id AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY region_id
            ORDER BY source_row_num ASC
        ) AS id_rank
    FROM cleaned_regions
),

deduplicated_region_name AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY  LOWER(region_name)
            ORDER BY region_id ASC
        ) AS name_rank
    FROM deduplicated_region_id
    WHERE id_rank = 1
)

SELECT
    region_id,
    region_name
FROM deduplicated_region_name
WHERE name_rank = 1