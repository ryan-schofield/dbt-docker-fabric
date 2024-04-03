SELECT DISTINCT ISNULL({{ dbt_utils.generate_surrogate_key(['investor', '1']) }}, '-1') AS investor_sid
    ,investor
FROM {{ ref('investors') }}
