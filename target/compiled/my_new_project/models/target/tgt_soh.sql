

SELECT
    itm_key,
    store_key,
    day_key,
    current_date  as end_day_key,
    f_unit_prc,
    f_oh_qty,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS

FROM DBT.DW_LND_tmp_rikesh_1.tmp_soh

