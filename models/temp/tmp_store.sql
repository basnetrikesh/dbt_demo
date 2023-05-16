select 
 store as store_id,
 * exclude(store)
 from {{ ref('stg_store') }}