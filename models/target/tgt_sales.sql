{{
     config(

     materialized='incremental',

     unique_key=['customer_key','store_key','txn_id'],

     merge_update_columns = ['RCD_UPD_TS',
     'TRAN_TYPE',
    'INVOICE_DATE',
    'TOTAL_REVENUE',
    'TOTAL_DISCOUNT',
    'TOTAL_UNITS',
    'TOTAL_COST',
    'TOTAL_TAX',
    'TOTAL_BILLS'
     ],

     )
}}
{% if is_incremental() %}
SELECT

    STORE_KEY,
    CUSTOMER_KEY,
    TXN_ID,
    TRAN_TYPE,
    INVOICE_DATE,
    TOTAL_REVENUE,
    TOTAL_DISCOUNT,
    TOTAL_UNITS,
    TOTAL_COST,
    TOTAL_TAX,
    TOTAL_BILLS,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS

FROM {{ref("tmp_sales")}}

{% else %}
  select
    STORE_KEY,
    CUSTOMER_KEY,
    TXN_ID,
    TRAN_TYPE,
    INVOICE_DATE,
    TOTAL_REVENUE,
    TOTAL_DISCOUNT,
    TOTAL_UNITS,
    TOTAL_COST,
    TOTAL_TAX,
    TOTAL_BILLS,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS
  from {{ ref('tmp_sales') }}
{% endif %}