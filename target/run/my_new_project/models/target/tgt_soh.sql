-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
        
    

    

    merge into DBT.DW_LND_tgt_rikesh_1.tgt_soh as DBT_INTERNAL_DEST
        using DBT.DW_LND_tgt_rikesh_1.tgt_soh__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.store_key = DBT_INTERNAL_DEST.store_key
                ) and (
                    DBT_INTERNAL_SOURCE.itm_key = DBT_INTERNAL_DEST.itm_key
                )

    
    when matched then update set
        RCD_UPD_TS = DBT_INTERNAL_SOURCE.RCD_UPD_TS,end_day_key = DBT_INTERNAL_SOURCE.end_day_key
    

    when not matched then insert
        ("ITM_KEY", "STORE_KEY", "DAY_KEY", "END_DAY_KEY", "F_UNIT_PRC", "F_OH_QTY", "RCD_INS_TS", "RCD_UPD_TS")
    values
        ("ITM_KEY", "STORE_KEY", "DAY_KEY", "END_DAY_KEY", "F_UNIT_PRC", "F_OH_QTY", "RCD_INS_TS", "RCD_UPD_TS")

;
    commit;