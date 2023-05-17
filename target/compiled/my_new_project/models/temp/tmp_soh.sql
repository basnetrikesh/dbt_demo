with tmp as(
    select itm.itm_key, loc.store_key,day_id as day_key, end_day_id as end_day_key, soh.* from DBT.DW_LND_stg_rikesh_1.stg_soh soh
    inner join DBT.DW_LND_tgt_rikesh_1.tgt_store loc on soh.store_id= loc.store_id
    inner join DBT.DW_LND_tgt_rikesh_1.tgt_product itm on soh.itm_id = itm.itm_id
)
select * from tmp