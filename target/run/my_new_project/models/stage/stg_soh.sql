
  create or replace   view DBT.DW_LND_stg_rikesh_1.stg_soh
  
   as (
    select
itm_id,
loc_id as store_id,
--current_date as day_id,
'2023-05-29' as day_id,
'9999-12-31' as end_day_id,
unit_price as f_unit_prc,
available_stock as f_oh_qty
from dbt.dw_lnd.soh
  );

