{% macro check_temp_reject (temp_table_name, src_table_name,target_table_name) %}
{%set temp_table_name = temp_table_name%}
{%set src_table_name = src_table_name%}
{%set target_table_name = target_table_name%}
{% set temp_count_query %}
select count(*) from DW_LND_TMP_RIKESH_1.{{temp_table_name}}
{%endset%}

{% set src_count_query %}
select count(*) from dw_lnd.{{src_table_name}}
{%endset%}

{% set temp_count = run_query(temp_count_query) %}
 {% if execute %}
{% set tmp_count = temp_count.rows[0][0] %}
{% else %}
{% set tmp_count = [] %}
{% endif %}
{% set src_count = run_query(src_count_query) %}
 {% if execute %}
{% set src_count = src_count.rows[0][0] %}
{% else %}
{% set src_count = [] %}
{% endif %}


{% if not tmp_count == src_count  %}
{% set reject_table %}REJ_{{target_table_name}}{%endset%}
{% set rej_table_exist_query %}
SELECT COUNT(*) FROM  INFORMATION_SCHEMA.TABLES
                    WHERE TABLE_NAME = '{{reject_table}}' AND TABLE_SCHEMA = 'DW_LND_REJ_RIKESH_1'
{%endset%}

{% set results = run_query(rej_table_exist_query) %}
    {% if execute %}
{% set results_list = results.rows[0][0] %}
{% else %}
{% set results_list = [] %}
{% endif %}
{%- if results_list == 0 -%}
{{log("The table doesnot exist so creating new rej table",true)}}

{% set create_rej_table_query%}

  CREATE TABLE {{this.schema}}.{{reject_table}}
                                   AS
                                   SELECT * FROM dw_lnd.{{src_table_name}}
                                   WHERE 1=0
{%endset%}
{% set alter_rej_table_query%}

    ALTER TABLE {{this.schema}}.{{reject_table}}
                                    ADD COLUMN
                                    BUSINESS_DT DATE, REJ_TIMESTAMP TIMESTAMP(6), BATCH_ID INTEGER, JOB_ID INTEGER
{%endset%}

{% do run_query(create_rej_table_query) %}
{% do run_query(alter_rej_table_query) %}
{%- endif -%}

{% set describe_src_query %}
describe table DW_LND_TMP_RIKESH_1.{{temp_table_name}}
{%endset%}

{%set columns = run_query(describe_src_query)%}
 {% if execute %}
{% set columns_list = columns.columns[0] %}
{% else %}
{% set columns_list = [] %}
{% endif %}
{%set col_list =  columns_list|join(', ') %}
{{log(col_list,true)}}
select {{col_list}},current_date as business_date, current_timestamp as rej_timestamp,'{{invocation_id}}' as batch_id, '{{invocation_id}}' as JOB_ID
from dw_lnd.{{src_table_name}} where ({{col_list}}) not in (select {{col_list}} from DW_LND_TMP_RIKESH_1.{{temp_table_name}})




{% else %}
{{log("There are no rejection",true)}}
select * from dual

{% endif %}





{%- endmacro -%}
