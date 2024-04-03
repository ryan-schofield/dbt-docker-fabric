SELECT ISNULL({{ dbt_utils.generate_surrogate_key(['investor', '1']) }}, '-1') AS investor_sid
    ,ISNULL({{ dbt_utils.generate_surrogate_key(['company', 'date_joined', 'industry']) }}, '-1') AS company_sid
    ,date_joined
    ,1 as count_investors
FROM {{ ref('investors') }}
