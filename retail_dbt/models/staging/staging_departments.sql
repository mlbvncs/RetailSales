WITH source_departments AS (
    SELECT
        *,
        ROW_NUMBER() OVER () AS source_row_num
    FROM {{ source('raw', 'departments') }}
),

null_removed AS (
    SELECT *
    FROM source_departments
    WHERE department_id IS NOT NULL AND TRIM(department_id) <> ''
        AND department_number IS NOT NULL AND TRIM(department_number) <> ''
        AND department_description IS NOT NULL AND TRIM(department_description) <> ''
),

format_validated AS (
    SELECT *
    FROM null_removed
    WHERE TRIM(department_id) ~ '^[0-9]+$' AND CAST(TRIM(department_id) AS INTEGER) > 0 
        AND TRIM(department_number) ~ '^[0-9]+$' AND CAST(TRIM(department_number) AS INTEGER) > 0
),

cleaned_departments AS (
    SELECT
        source_row_num,
        CAST(TRIM(department_id) AS INTEGER) AS department_id,
        CAST(TRIM(department_id) AS INTEGER) AS department_number,
        array_to_string(
            ARRAY(
                SELECT array_to_string(
                    ARRAY(
                        SELECT UPPER(LEFT(subword, 1)) || LOWER(SUBSTRING(subword FROM 2))
                        FROM unnest(string_to_array(word, '/')) AS subword
                    ),
                    '/'
                )
                FROM unnest(
                    string_to_array(
                        TRIM(REGEXP_REPLACE(department_description, '\s+', ' ', 'g')),
                        ' '
                    )
                ) AS word
            ),
            ' '
        ) AS department_description
    FROM format_validated
),

deduplicated_department_id AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY source_row_num ASC
        ) AS id_rank
    FROM cleaned_departments
)

SELECT
    department_id,
    department_number,
    department_description
FROM deduplicated_department_id
WHERE id_rank = 1 