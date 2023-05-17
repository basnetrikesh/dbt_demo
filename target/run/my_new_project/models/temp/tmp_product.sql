
  
    

        create or replace transient table DBT.DW_LND_tmp_rikesh_1.tmp_product  as
        (select * from DBT.DW_LND_stg_rikesh_1.stg_product
        );
      
  