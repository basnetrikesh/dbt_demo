with tmp as
(

 select st.store_key,ct.customer_key,sl.* from {{ref("stg_sales")}} sl

    inner join dw_lnd_tgt_rikesh_1.tgt_store st on sl.store_id = st.store_id

    inner join dw_lnd_tgt_rikesh_1.tgt_customer ct on ct.customerid = sl.customerid
)

select * from tmp