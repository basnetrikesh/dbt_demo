
  create or replace   view DBT.DW_LND_stg_rikesh_1.stg_product
  
   as (
    select * from dbt.dw_lnd.product
  );

