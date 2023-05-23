

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


