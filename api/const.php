<?php

class DataFlag
{
    const TRANSACTION_FLAG_CLEARING = 1; // 0 = Direct, 1 = Accounting
    const TRANSACTION_FLAG_GUARANTEE = 2; // Payment guarantee
    const TRANSACTION_FLAG_3DSECURE = 3; // 3D-Secure
    const TRANSACTION_FLAG_EXT_API = 4; // 0 = XML, 1 = iFrame
    const TRANSACTION_FLAG_DEMO = 5; // Demo
    const TRANSACTION_FLAG_AUTHORIZATION = 6; // Pre-auth payment
    const TRANSACTION_FLAG_ACCRUAL = 7; // Block paying-out process
    const TRANSACTION_FLAG_STAKEHOLDER_EVALUATED = 8; // Transfer of the stakeholder amount (done)
    const TRANSACTION_FLAG_BASKET_EVALUATED = 9; // Basket was analyzed
    const TRANSACTION_FLAG_BASKET_ITEM_EVALUATED = 10; // Basket position was analyzed
    const TRANSACTION_FLAG_SECUCORE = 11; // Transaction was created via secucore
    const TRANSACTION_FLAG_CHECKOUT = 12; // Transaction was created for the smart checkout (STX with intend 'checkout' or 'order')
    const TRANSACTION_FLAG_LVP = 13; // Transaction was created with Low Value Payment Flag for Transact
    const TRANSACTION_FLAG_TRA = 14; // Transaction was created with Transaction Risk Analyze Flag for Transact
    const TRANSACTION_FLAG_MIT = 15; // Transaction was merchant initiated
}
