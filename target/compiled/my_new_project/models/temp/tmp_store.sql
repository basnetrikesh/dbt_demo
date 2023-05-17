select 
 store as store_id,
 * exclude(store)
 from DBT.DW_LND_stg_rikesh_1.stg_store