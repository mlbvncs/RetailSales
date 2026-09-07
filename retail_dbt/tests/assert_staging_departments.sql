WITH duplicates AS (
    SELECT 
        LOWER(department_description) AS department_description_lower,
        COUNT(*) AS occurrence_count,
        ARRAY_AGG(department_id ORDER BY department_id) AS department_ids,
        ARRAY_AGG(department_description ORDER BY department_id) AS department_descriptions
    FROM {{ ref('staging_departments') }}
    GROUP BY LOWER(department_description)
    HAVING COUNT(*) > 1
)

SELECT 
    department_description_lower,
    occurrence_count,
    department_ids,
    department_descriptions
FROM duplicates