SELECT company
    ,CAST(REPLACE(valuation_billions, '$', '') AS FLOAT) AS valuation_billions
    ,CAST(date_joined AS DATE) AS date_joined
    ,country
    ,city
    ,industry
    ,select_investors
FROM {{ source('raw', 'unicorn') }}
