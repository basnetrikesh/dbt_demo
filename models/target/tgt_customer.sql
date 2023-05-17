{{
     config(

     materialized='incremental',

     unique_key='customerid',

     merge_update_columns = ['RCD_UPD_TS','customer_name','customer_type'],
     post_hook="""
    -- Update RCD_CLOSE_FLG
    update {{ this }}
    set
      RCD_CLOSE_FLG = 'Y',
      RCD_CLOSE_DT = current_date()
    where customerid not in (select customerid from {{ ref('tmp_customer') }});
    """

     )
}}
{% if is_incremental() %}
SELECT

    COALESCE((SELECT MAX(customer_key) FROM {{ this }}), 0) + 1 as customer_key,

    customerid,

    customer_name,

    customer_type,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS,

    'N' as RCD_CLOSE_FLG,

    '9999-12-31' as RCD_CLOSE_DT

FROM {{ref("tmp_customer")}}

{% else %}
  select
    row_number() over (order by customerid) as customer_key,
    customerid,
    customer_name,
    customer_type,
    current_timestamp as RCD_INS_TS,
    current_timestamp as RCD_UPD_TS,
    'N' as RCD_CLOSE_FLG,
    '9999-12-31' as RCD_CLOSE_DT
  from {{ ref('tmp_customer') }}
{% endif %}