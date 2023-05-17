
  create or replace   view DBT.DW_LND_stg_rikesh_1.stg_store
  
   as (
    select * from dbt.dw_lnd.store_dbt
  );

