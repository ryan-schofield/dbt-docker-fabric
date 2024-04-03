SELECT c.company
    ,c.date_joined
    ,c.industry
    ,TRIM(i.[value]) AS investor
FROM {{ ref('companies') }} c
CROSS APPLY STRING_SPLIT(c.select_investors, ',') i
