

SELECT

    COALESCE((SELECT MAX(customer_key) FROM DBT.DW_LND_tgt_rikesh_1.tgt_customer), 0) + 1 as customer_key,

    customerid,

    customer_name,

    customer_type,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS,

    'N' as RCD_CLOSE_FLG,

    '9999-12-31' as RCD_CLOSE_DT

FROM DBT.DW_LND_tmp_rikesh_1.tmp_customer

