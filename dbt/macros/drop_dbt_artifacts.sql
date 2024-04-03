{%- macro drop_dbt_artifacts() -%}

{%- set get_artifacts_query -%}
SELECT 'DROP ' + IIF(TABLE_TYPE = 'VIEW', 'VIEW ', 'TABLE ') + TABLE_SCHEMA + '.' + TABLE_NAME AS drop_statements
FROM INFORMATION_SCHEMA.TABLES t
WHERE t.TABLE_NAME LIKE '%__dbt_tmp%'
{%- endset -%}

{%- call statement('get_query_results', fetch_result=True, auto_begin=false) -%}
    {{ get_artifacts_query }}
{%- endcall -%}

{%- set results_list = [] %}
{%- if execute %}
    {%- set results_list = load_result('get_query_results').data %}
    {%- for item in results_list %}
        {{ log('RUNNING STATEMENT: {0}'.format(item[0]), info=True) }}
        {%- call statement('drop_table', fetch_result=False, auto_begin=false) -%}
            {{ item[0] }}
        {%- endcall -%}
    {%- endfor %}
{%- endif %}

{%- endmacro -%}