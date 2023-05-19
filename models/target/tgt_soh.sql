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
        '9999-12-31' as end_day_key,
        f_unit_prc,
        f_oh_qty,
        current_timestamp as RCD_INS_TS,
        current_timestamp as RCD_UPD_TS
    from (
    with tgt_open as 
    (
    select 
    itm_key,
    store_key,
    f_oh_qty,
    f_unit_prc
     from DBT.DW_LND_TGT_RIKESH_1.TGT_SOH where end_day_key = '9999-12-31'
    ),
    tmp as(
    select * from  DBT.DW_LND_tmp_RIKESH_1.tmp_SOH
    )
    select src.* from tmp src left join tgt_open tgt on src.itm_key = tgt.itm_key and src.store_key = tgt.store_key 
    where (src.f_oh_qty <> tgt.f_oh_qty or src.f_unit_prc <> tgt.f_unit_prc)
    or (tgt.f_oh_qty is null and tgt.f_unit_prc is null)
    )
     where (select count(distinct end_day_key) from {{ this }})>1
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

FROM(
    with tgt_open as 
    (
    select 
    itm_key,
    store_key,
    f_oh_qty,
    f_unit_prc
     from DBT.DW_LND_TGT_RIKESH_1.TGT_SOH where end_day_key = '9999-12-31'
    ),
    tmp as(
    select * from  DBT.DW_LND_tmp_RIKESH_1.tmp_SOH
    )
    select src.* from tmp src left join tgt_open tgt on src.itm_key = tgt.itm_key and src.store_key = tgt.store_key 
    where (src.f_oh_qty <> tgt.f_oh_qty or src.f_unit_prc <> tgt.f_unit_prc)
)

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