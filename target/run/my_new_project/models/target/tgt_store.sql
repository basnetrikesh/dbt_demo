-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DBT.DW_LND_tgt_rikesh_1.tgt_store as DBT_INTERNAL_DEST
        using DBT.DW_LND_tgt_rikesh_1.tgt_store__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.store_id = DBT_INTERNAL_DEST.store_id
            )

    
    when matched then update set
        RCD_UPD_TS = DBT_INTERNAL_SOURCE.RCD_UPD_TS,STORE_NAME = DBT_INTERNAL_SOURCE.STORE_NAME,STORE_NAME10 = DBT_INTERNAL_SOURCE.STORE_NAME10,STORE_NAME3 = DBT_INTERNAL_SOURCE.STORE_NAME3,STORE_NAME_SECONDARY = DBT_INTERNAL_SOURCE.STORE_NAME_SECONDARY,STORE_CLASS = DBT_INTERNAL_SOURCE.STORE_CLASS,STORE_MGR_NAME = DBT_INTERNAL_SOURCE.STORE_MGR_NAME,STORE_OPEN_DATE = DBT_INTERNAL_SOURCE.STORE_OPEN_DATE,STORE_CLOSE_DATE = DBT_INTERNAL_SOURCE.STORE_CLOSE_DATE,ACQUIRED_DATE = DBT_INTERNAL_SOURCE.ACQUIRED_DATE,REMODEL_DATE = DBT_INTERNAL_SOURCE.REMODEL_DATE,FAX_NUMBER = DBT_INTERNAL_SOURCE.FAX_NUMBER,PHONE_NUMBER = DBT_INTERNAL_SOURCE.PHONE_NUMBER,EMAIL = DBT_INTERNAL_SOURCE.EMAIL,TOTAL_SQUARE_FT = DBT_INTERNAL_SOURCE.TOTAL_SQUARE_FT,SELLING_SQUARE_FT = DBT_INTERNAL_SOURCE.SELLING_SQUARE_FT,LINEAR_DISTANCE = DBT_INTERNAL_SOURCE.LINEAR_DISTANCE,VAT_REGION = DBT_INTERNAL_SOURCE.VAT_REGION,VAT_INCLUDE_IND = DBT_INTERNAL_SOURCE.VAT_INCLUDE_IND,STOCKHOLDING_IND = DBT_INTERNAL_SOURCE.STOCKHOLDING_IND,CHANNEL_ID = DBT_INTERNAL_SOURCE.CHANNEL_ID,STORE_FORMAT = DBT_INTERNAL_SOURCE.STORE_FORMAT,MALL_NAME = DBT_INTERNAL_SOURCE.MALL_NAME,DISTRICT = DBT_INTERNAL_SOURCE.DISTRICT,TRANSFER_ZONE = DBT_INTERNAL_SOURCE.TRANSFER_ZONE,DEFAULT_WH = DBT_INTERNAL_SOURCE.DEFAULT_WH,STOP_ORDER_DAYS = DBT_INTERNAL_SOURCE.STOP_ORDER_DAYS,START_ORDER_DAYS = DBT_INTERNAL_SOURCE.START_ORDER_DAYS,CURRENCY_CODE = DBT_INTERNAL_SOURCE.CURRENCY_CODE,LANG = DBT_INTERNAL_SOURCE.LANG,TRAN_NO_GENERATED = DBT_INTERNAL_SOURCE.TRAN_NO_GENERATED,INTEGRATED_POS_IND = DBT_INTERNAL_SOURCE.INTEGRATED_POS_IND,ORIG_CURRENCY_CODE = DBT_INTERNAL_SOURCE.ORIG_CURRENCY_CODE,DUNS_NUMBER = DBT_INTERNAL_SOURCE.DUNS_NUMBER,DUNS_LOC = DBT_INTERNAL_SOURCE.DUNS_LOC,SISTER_STORE = DBT_INTERNAL_SOURCE.SISTER_STORE,TSF_ENTITY_ID = DBT_INTERNAL_SOURCE.TSF_ENTITY_ID,ORG_UNIT_ID = DBT_INTERNAL_SOURCE.ORG_UNIT_ID,AUTO_RCV = DBT_INTERNAL_SOURCE.AUTO_RCV,REMERCH_IND = DBT_INTERNAL_SOURCE.REMERCH_IND,STORE_TYPE = DBT_INTERNAL_SOURCE.STORE_TYPE,WF_CUSTOMER_ID = DBT_INTERNAL_SOURCE.WF_CUSTOMER_ID,TIMEZONE_NAME = DBT_INTERNAL_SOURCE.TIMEZONE_NAME,CUSTOMER_ORDER_LOC_IND = DBT_INTERNAL_SOURCE.CUSTOMER_ORDER_LOC_IND,CREATE_ID = DBT_INTERNAL_SOURCE.CREATE_ID,CREATE_DATETIME = DBT_INTERNAL_SOURCE.CREATE_DATETIME
    

    when not matched then insert
        ("STORE_KEY", "STORE_ID", "STORE_NAME", "STORE_NAME10", "STORE_NAME3", "STORE_NAME_SECONDARY", "STORE_CLASS", "STORE_MGR_NAME", "STORE_OPEN_DATE", "STORE_CLOSE_DATE", "ACQUIRED_DATE", "REMODEL_DATE", "FAX_NUMBER", "PHONE_NUMBER", "EMAIL", "TOTAL_SQUARE_FT", "SELLING_SQUARE_FT", "LINEAR_DISTANCE", "VAT_REGION", "VAT_INCLUDE_IND", "STOCKHOLDING_IND", "CHANNEL_ID", "STORE_FORMAT", "MALL_NAME", "DISTRICT", "TRANSFER_ZONE", "DEFAULT_WH", "STOP_ORDER_DAYS", "START_ORDER_DAYS", "CURRENCY_CODE", "LANG", "TRAN_NO_GENERATED", "INTEGRATED_POS_IND", "ORIG_CURRENCY_CODE", "DUNS_NUMBER", "DUNS_LOC", "SISTER_STORE", "TSF_ENTITY_ID", "ORG_UNIT_ID", "AUTO_RCV", "REMERCH_IND", "STORE_TYPE", "WF_CUSTOMER_ID", "TIMEZONE_NAME", "CUSTOMER_ORDER_LOC_IND", "CREATE_ID", "CREATE_DATETIME", "RCD_INS_TS", "RCD_UPD_TS", "RCD_CLOSE_FLG", "RCD_CLOSE_DT")
    values
        ("STORE_KEY", "STORE_ID", "STORE_NAME", "STORE_NAME10", "STORE_NAME3", "STORE_NAME_SECONDARY", "STORE_CLASS", "STORE_MGR_NAME", "STORE_OPEN_DATE", "STORE_CLOSE_DATE", "ACQUIRED_DATE", "REMODEL_DATE", "FAX_NUMBER", "PHONE_NUMBER", "EMAIL", "TOTAL_SQUARE_FT", "SELLING_SQUARE_FT", "LINEAR_DISTANCE", "VAT_REGION", "VAT_INCLUDE_IND", "STOCKHOLDING_IND", "CHANNEL_ID", "STORE_FORMAT", "MALL_NAME", "DISTRICT", "TRANSFER_ZONE", "DEFAULT_WH", "STOP_ORDER_DAYS", "START_ORDER_DAYS", "CURRENCY_CODE", "LANG", "TRAN_NO_GENERATED", "INTEGRATED_POS_IND", "ORIG_CURRENCY_CODE", "DUNS_NUMBER", "DUNS_LOC", "SISTER_STORE", "TSF_ENTITY_ID", "ORG_UNIT_ID", "AUTO_RCV", "REMERCH_IND", "STORE_TYPE", "WF_CUSTOMER_ID", "TIMEZONE_NAME", "CUSTOMER_ORDER_LOC_IND", "CREATE_ID", "CREATE_DATETIME", "RCD_INS_TS", "RCD_UPD_TS", "RCD_CLOSE_FLG", "RCD_CLOSE_DT")

;
    commit;