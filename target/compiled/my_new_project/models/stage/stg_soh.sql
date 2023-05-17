select
itm_id,
loc_id as store_id,
dateadd(day, 1,current_date::date) as day_id,
'9999-12-31' as end_day_id,
unit_price as f_unit_prc,
available_stock as f_oh_qty
from dbt.dw_lnd.soh