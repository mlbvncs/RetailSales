WITH source_brands AS (
    SELECT
        *,
        ROW_NUMBER() OVER () AS source_row_num
    FROM {{ source('raw', 'brands') }}
),

null_removed AS (
    SELECT *
    FROM source_brands
    WHERE brand_id IS NOT NULL AND TRIM(brand_id) <> ''
      AND brand_description IS NOT NULL AND TRIM(brand_description) <> ''
),

format_validated AS (
    SELECT *
    FROM null_removed
    WHERE TRIM(brand_id) ~ '^[0-9]+$'
      AND CAST(TRIM(brand_id) AS INTEGER) > 0 
),

cleaned_brands AS (
    SELECT
        source_row_num,
        CAST(TRIM(brand_id) AS INTEGER) AS brand_id,
        array_to_string(
            ARRAY(
                SELECT UPPER(LEFT(word, 1)) || SUBSTRING(word FROM 2)
                FROM unnest(
                    string_to_array(
                        TRIM(REGEXP_REPLACE(brand_description, '\s+', ' ', 'g')),
                        ' '
                    )
                ) AS word
            ),
            ' '
        ) AS brand_description
    FROM format_validated
),

deduplicated_brand_id AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY brand_id
            ORDER BY source_row_num ASC
        ) AS id_rank
    FROM cleaned_brands
),

deduplicated_brand_description AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY LOWER(brand_description)
            ORDER BY brand_id ASC
        ) AS description_rank
    FROM deduplicated_brand_id
    WHERE id_rank = 1
)

SELECT
    brand_id,
    brand_description
FROM deduplicated_brand_description
WHERE description_rank = 1 