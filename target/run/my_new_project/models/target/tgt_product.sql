-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DBT.DW_LND_tgt_rikesh_1.tgt_product as DBT_INTERNAL_DEST
        using DBT.DW_LND_tgt_rikesh_1.tgt_product__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.itm_id = DBT_INTERNAL_DEST.itm_id
            )

    
    when matched then update set
        RCD_UPD_TS = DBT_INTERNAL_SOURCE.RCD_UPD_TS,itm_desc = DBT_INTERNAL_SOURCE.itm_desc,category = DBT_INTERNAL_SOURCE.category
    

    when not matched then insert
        ("ITM_KEY", "ITM_ID", "ITM_DESC", "CATEGORY", "RCD_INS_TS", "RCD_UPD_TS", "RCD_CLOSE_FLG", "RCD_CLOSE_DT")
    values
        ("ITM_KEY", "ITM_ID", "ITM_DESC", "CATEGORY", "RCD_INS_TS", "RCD_UPD_TS", "RCD_CLOSE_FLG", "RCD_CLOSE_DT")

;
    commit;