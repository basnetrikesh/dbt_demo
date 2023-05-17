-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
                
                
            
        
    

    

    merge into DBT.DW_LND_tgt_rikesh_1.tgt_sales as DBT_INTERNAL_DEST
        using DBT.DW_LND_tgt_rikesh_1.tgt_sales__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.customer_key = DBT_INTERNAL_DEST.customer_key
                ) and (
                    DBT_INTERNAL_SOURCE.store_key = DBT_INTERNAL_DEST.store_key
                ) and (
                    DBT_INTERNAL_SOURCE.txn_id = DBT_INTERNAL_DEST.txn_id
                )

    
    when matched then update set
        RCD_UPD_TS = DBT_INTERNAL_SOURCE.RCD_UPD_TS,TRAN_TYPE = DBT_INTERNAL_SOURCE.TRAN_TYPE,INVOICE_DATE = DBT_INTERNAL_SOURCE.INVOICE_DATE,TOTAL_REVENUE = DBT_INTERNAL_SOURCE.TOTAL_REVENUE,TOTAL_DISCOUNT = DBT_INTERNAL_SOURCE.TOTAL_DISCOUNT,TOTAL_UNITS = DBT_INTERNAL_SOURCE.TOTAL_UNITS,TOTAL_COST = DBT_INTERNAL_SOURCE.TOTAL_COST,TOTAL_TAX = DBT_INTERNAL_SOURCE.TOTAL_TAX,TOTAL_BILLS = DBT_INTERNAL_SOURCE.TOTAL_BILLS
    

    when not matched then insert
        ("STORE_KEY", "CUSTOMER_KEY", "TXN_ID", "TRAN_TYPE", "INVOICE_DATE", "TOTAL_REVENUE", "TOTAL_DISCOUNT", "TOTAL_UNITS", "TOTAL_COST", "TOTAL_TAX", "TOTAL_BILLS", "RCD_INS_TS", "RCD_UPD_TS")
    values
        ("STORE_KEY", "CUSTOMER_KEY", "TXN_ID", "TRAN_TYPE", "INVOICE_DATE", "TOTAL_REVENUE", "TOTAL_DISCOUNT", "TOTAL_UNITS", "TOTAL_COST", "TOTAL_TAX", "TOTAL_BILLS", "RCD_INS_TS", "RCD_UPD_TS")

;
    commit;