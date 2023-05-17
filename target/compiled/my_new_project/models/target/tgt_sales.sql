

SELECT

    STORE_KEY,
    CUSTOMER_KEY,
    TXN_ID,
    TRAN_TYPE,
    INVOICE_DATE,
    TOTAL_REVENUE,
    TOTAL_DISCOUNT,
    TOTAL_UNITS,
    TOTAL_COST,
    TOTAL_TAX,
    TOTAL_BILLS,

    current_timestamp as RCD_INS_TS,

    current_timestamp as RCD_UPD_TS

FROM DBT.DW_LND_tmp_rikesh_1.tmp_sales

