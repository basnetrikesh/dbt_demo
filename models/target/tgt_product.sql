{{
     config(

     materialized='incremental',

     unique_key='itm_id',

     merge_update_columns = ['RCD_UPD_TS','itm_desc','category'],
     post_hook="""
    -- Update RCD_CLOSE_FLG
    update {{ this }}
    set
      RCD_CLOSE_FLG = 'Y',
      RCD_CLOSE_DT = current_date()
    where itm_id not in (select itm_id from {{ ref('tmp_product') }});
    """

     )
}}
{% if is_incremental() %}
SELECT

    COALESCE((SELECT MAX(itm_key) FROM {{ this }}), 0) + 1 as itm_key,

    itm_id,
    itm_desc,
    category,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS,

    'N' as RCD_CLOSE_FLG,

    '9999-12-31' as RCD_CLOSE_DT

FROM {{ref("tmp_product")}}

{% else %}
  select
    row_number() over (order by itm_id) as itm_key,
    itm_id,
    itm_desc,
    category,
    current_timestamp as RCD_INS_TS,
    current_timestamp as RCD_UPD_TS,
    'N' as RCD_CLOSE_FLG,
    '9999-12-31' as RCD_CLOSE_DT
  from {{ ref('tmp_product') }}
{% endif %}