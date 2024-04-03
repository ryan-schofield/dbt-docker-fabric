SELECT ISNULL({{ dbt_utils.generate_surrogate_key(['company', 'date_joined', 'industry']) }}, '-1') AS company_sid
    ,date_joined
    ,valuation_billions
    ,1 as count_companies
FROM {{ ref('companies') }}
