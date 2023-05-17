


  SELECT
    COALESCE((SELECT MAX(store_key) FROM DBT.DW_LND_tgt_rikesh_1.tgt_store), 0) + 1 as store_key,
    store_id,
    STORE_NAME,
    STORE_NAME10,
    STORE_NAME3,
    STORE_NAME_SECONDARY,
    STORE_CLASS,
    STORE_MGR_NAME,
    STORE_OPEN_DATE,
    STORE_CLOSE_DATE,
    ACQUIRED_DATE,
    REMODEL_DATE,
    FAX_NUMBER,
    PHONE_NUMBER,
    EMAIL,
    TOTAL_SQUARE_FT,
    SELLING_SQUARE_FT,
    LINEAR_DISTANCE,
    VAT_REGION,
    VAT_INCLUDE_IND,
    STOCKHOLDING_IND,
    CHANNEL_ID,
    STORE_FORMAT,
    MALL_NAME,
    DISTRICT,
    TRANSFER_ZONE,
    DEFAULT_WH,
    STOP_ORDER_DAYS,
    START_ORDER_DAYS,
    CURRENCY_CODE,
    LANG,
    TRAN_NO_GENERATED,
    INTEGRATED_POS_IND,
    ORIG_CURRENCY_CODE,
    DUNS_NUMBER,
    DUNS_LOC,
    SISTER_STORE,
    TSF_ENTITY_ID,
    ORG_UNIT_ID,
    AUTO_RCV,
    REMERCH_IND,
    STORE_TYPE,
    WF_CUSTOMER_ID,
    TIMEZONE_NAME,
    CUSTOMER_ORDER_LOC_IND,
    CREATE_ID,
    CREATE_DATETIME,
    current_timestamp as RCD_INS_TS,
    current_timestamp as RCD_UPD_TS,
    'N' as RCD_CLOSE_FLG,
    '9999-12-31' as RCD_CLOSE_DT
  FROM DBT.DW_LND_tmp_rikesh_1.tmp_store

