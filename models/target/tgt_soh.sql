{{
     config(

     materialized='incremental',

     unique_key=['store_key','itm_key'],

     merge_update_columns = ['RCD_UPD_TS','end_day_key'],
    post_hook="""
    --insert temp data
    insert into {{ this }}
    (
          select
        itm_key,
        store_key,
        day_key,
        end_day_key,
        f_unit_prc,
        f_oh_qty,
        current_timestamp as RCD_INS_TS,
        current_timestamp as RCD_UPD_TS
    from {{ ref('tmp_soh') }}
    )
    ;
    """

     )
}}
{% if is_incremental() %}
SELECT
    itm_key,
    store_key,
    day_key,
    current_date  as end_day_key,
    f_unit_prc,
    f_oh_qty,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS

FROM {{ref("tmp_soh")}}

{% else %}
  select
    itm_key,
    store_key,
    day_key,
    end_day_key,
    f_unit_prc,
    f_oh_qty,
    current_timestamp as RCD_INS_TS,
    current_timestamp as RCD_UPD_TS
  from {{ ref('tmp_soh') }}
{% endif %}