{{
     config(

     materialized='incremental',

     post_hook="""
--deleting unchanged records from tmp
delete from DBT.DW_LND_tmp_RIKESH_1.tmp_SOH tmp using {{ this }} tgt
where tmp.store_key= tgt.store_key and
tmp.itm_key = tgt.itm_key and
tgt.end_day_key = '9999-12-31' and
tmp.f_oh_qty= tgt.f_oh_qty and
tmp.f_unit_prc=tgt.f_unit_prc;

--for_month_end_closing
insert into DBT.DW_LND_tmp_RIKESH_1.tmp_SOH (ITM_KEY ,STORE_KEY ,DAY_KEY ,END_DAY_KEY ,ITM_ID ,STORE_ID ,DAY_ID ,END_DAY_ID ,F_UNIT_PRC ,F_OH_QTY)
(
    select 
    itm.itm_key,
    loc.store_key,
    tim.DAY_KEY ,
    '9999-12-31' ,
    itm.itm_id ,
    loc.store_id ,
    tgt.day_key ,
    '9999-12-31' ,
    tgt.F_UNIT_PRC ,
    tgt.F_OH_QTY 
     from
    {{ this }} tgt inner join {{ref('tgt_store')}} loc on tgt.store_key= loc.store_key
    inner join {{ ref('tgt_product')}} itm on tgt.itm_key = itm.ITM_KEY
    inner join DBT.DW_LND.DWH_D_TIM_DAY_LU tim on tim.day_key = (select distinct day_id from {{ref('stg_soh')}})
    where tgt.DAY_KEY < tim.MTH_START_DT and tim.DAY_KEY = tim.MTH_START_DT and tgt.END_DAY_key ='9999-12-31'
    and (tgt.ITM_KEY,tgt.STORE_KEY) not in (select distinct itm_key, store_key from DBT.DW_LND_tmp_RIKESH_1.tmp_SOH)
);

 --update query
  UPDATE DBT.DW_LND_tgt_RIKESH_1.tgt_SOH tgt
                                SET END_DAY_KEY=dateadd(day,-1,to_date(src.DAY_KEY))
                                , RCD_UPD_TS=CURRENT_TIMESTAMP
                            FROM DBT.DW_LND_tmp_RIKESH_1.tmp_SOH src
                            WHERE src.ITM_KEY = tgt.ITM_KEY AND src. STORE_KEY = tgt.STORE_KEY
                                AND TGT.END_DAY_KEY='9999-12-31';

-- insert query
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
    from DBT.DW_LND_tmp_RIKESH_1.tmp_SOH);
    """
     )
}}
{% if is_incremental() %}
--only new data inserted(dummy)
SELECT
    itm_key,
    store_key,
    day_key,
    '9999-12-31'  as end_day_key,
    f_unit_prc,
    f_oh_qty,
    current_timestamp as RCD_INS_TS,
    current_timestamp as RCD_UPD_TS

FROM(
    select src.* from DBT.DW_LND_tmp_RIKESH_1.tmp_SOH src left join DBT.DW_LND_TGT_RIKESH_1.TGT_SOH tgt on src.itm_key = tgt.itm_key and src.store_key = tgt.store_key 
    where (tgt.f_oh_qty is null and tgt.f_unit_prc is null)
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