SELECT ISNULL({{ dbt_utils.generate_surrogate_key(['company', 'date_joined', 'industry']) }}, '-1') AS company_sid
    ,company AS company_name
    ,date_joined
    ,country
    ,city
    ,industry
FROM {{ ref('companies') }}
