
  
    

        create or replace transient table DBT.DW_LND_tmp_rikesh_1.tmp_store  as
        (select 
 store as store_id,
 * exclude(store)
 from DBT.DW_LND_stg_rikesh_1.stg_store
        );
      
  