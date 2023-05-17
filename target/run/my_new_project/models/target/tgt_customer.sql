-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DBT.DW_LND_tgt_rikesh_1.tgt_customer as DBT_INTERNAL_DEST
        using DBT.DW_LND_tgt_rikesh_1.tgt_customer__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.customerid = DBT_INTERNAL_DEST.customerid
            )

    
    when matched then update set
        RCD_UPD_TS = DBT_INTERNAL_SOURCE.RCD_UPD_TS,customer_name = DBT_INTERNAL_SOURCE.customer_name,customer_type = DBT_INTERNAL_SOURCE.customer_type
    

    when not matched then insert
        ("CUSTOMER_KEY", "CUSTOMERID", "CUSTOMER_NAME", "CUSTOMER_TYPE", "RCD_INS_TS", "RCD_UPD_TS", "RCD_CLOSE_FLG", "RCD_CLOSE_DT")
    values
        ("CUSTOMER_KEY", "CUSTOMERID", "CUSTOMER_NAME", "CUSTOMER_TYPE", "RCD_INS_TS", "RCD_UPD_TS", "RCD_CLOSE_FLG", "RCD_CLOSE_DT")

;
    commit;