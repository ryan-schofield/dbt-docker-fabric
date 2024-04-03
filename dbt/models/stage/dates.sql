{%- set start_date = "'2011-04-02'" -%}
{%- set end_date = "'2023-03-14'" -%}

SELECT CAST(NULLIF(DATEADD(DAY, y.int_range, {{ start_date }}), '1900-01-01') AS DATE) AS date_sid
FROM (
    SELECT ones.int_val + (10 * tens.int_val) + (100 * hundreds.int_val) + (1000 * thousands.int_val) AS int_range
    FROM dw_seed.integers ones
    CROSS APPLY {{ ref('integers') }} tens
    CROSS APPLY {{ ref('integers') }} hundreds
    CROSS APPLY {{ ref('integers') }} thousands
    ) y
WHERE y.int_range <= DATEDIFF(DAY, {{ start_date }}, {{ end_date }})
