
  create or replace   view DBT.DW_LND_stg_rikesh_1.stg_customer
  
   as (
    log_filepath: logs/stg_customer.log
select * from dbt.dw_lnd.customer
  );

