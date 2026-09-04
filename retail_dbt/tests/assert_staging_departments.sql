SELECT 
    LOWER(department_description) AS department_description_lower, 
    COUNT(*) AS qtd
FROM {{ ref('staging_departments') }}
GROUP BY LOWER(department_description)
HAVING COUNT(*) > 1