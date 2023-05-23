-- back compat for old kwarg name
  
  begin;
    

        insert into DBT.DW_LND_tgt_rikesh_1.tgt_soh ("ITM_KEY", "STORE_KEY", "DAY_KEY", "END_DAY_KEY", "F_UNIT_PRC", "F_OH_QTY", "RCD_INS_TS", "RCD_UPD_TS")
        (
            select "ITM_KEY", "STORE_KEY", "DAY_KEY", "END_DAY_KEY", "F_UNIT_PRC", "F_OH_QTY", "RCD_INS_TS", "RCD_UPD_TS"
            from DBT.DW_LND_tgt_rikesh_1.tgt_soh__dbt_tmp
        );
    commit;