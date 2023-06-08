{%- macro insert_using_temp( dim_key_list,dim_idnt_list,temp_table_column_list, temp_table,temp_db ) -%}
{%set temp_table_column =  temp_table_column_list%}
{%set dim_key =  dim_key_list %}
{%set dim_idnt =  dim_idnt_list %}
{%set target_table%}{{this.name}}{%endset%}
{%set dim_idnt_list = dim_idnt.split(',') %}
{{log(dim_idnt_list,true)}}
{%set dim_join_cond = [] %}
{% set dim_idnt_join_list %}
{% for x in dim_idnt_list %}
src.{{ x }} = tgt.{{ x }} {% if not loop.last %} AND {% endif %}
{% endfor %}
{%endset%}
{{log(dim_idnt_join_list,true)}}

{% set target_table_exist_query %}
SELECT COUNT(*) FROM  INFORMATION_SCHEMA.TABLES
                    WHERE TABLE_NAME = '{{this.name}}' AND TABLE_SCHEMA = '{{this.schema}}'
{%endset%}

{% set results = run_query(target_table_exist_query) %}
    {% if execute %}
{% set results_list = results.rows[0][0] %}
{% else %}
{% set results_list = [] %}
{% endif %}
{%- if results_list == 0 -%}

{}





{% set run_query %}
with cte as(
            SELECT COALESCE((SELECT MAX({{dim_key}})
                FROM {{this.schema}}.{{target_table}}
                WHERE {{dim_key}}>=0), 0) + RANK()
                OVER (ORDER BY {{dim_idnt}})
            , {{dim_idnt}}
            , {{temp_table_column}}
            , current_timestamp
            , current_timestamp
            ,0 AS RCD_CLOSE_FLG,
            '9999-12-31' AS RCD_CLOSE_DT
            FROM {{temp_db}}.{{temp_table}}  src
            WHERE NOT EXISTS
            (SELECT 1
            FROM {{this.schema}}.{{target_table}} tgt WHERE {{dim_idnt_join_list}}))
            select * from cte
{%endset%}
{{log(run_query,true)}}

{{run_query}}


{%- endmacro -%}