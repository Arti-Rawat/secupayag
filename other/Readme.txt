Step 1
There should be some API endpoint to get the current server time.

Run the PHPunit test case : 
./vendor/bin/phpunit tests/ServerTimeApiTest.php


Step 2
There should be some API tests for this (by using codeception / phpunit).

Run the PHPunit test case : 
./vendor/bin/phpunit tests/ServerTimeApiTest.php

Step 3
The access to the API should be protected by an access token, which needs to be valid.
Hints:
the access tokens are stored in 'api_apikey'
you will need the table 'vorgaben_zeitraum' for the validation check

Run the PHPunit test case : 
./vendor/bin/phpunit tests/ServerTimeApiTest.php

Step 4
There should be an API endpoint to get a list of active "FlagBits".
This endpoint has an input field 'trans_id'.
This endpoint only allows access to transactions which belongs to the API user.
Hints:
the transactions are stored in 'transaktion_transaktionen'
the "FlagBits" for are stored in 'stamd_flagbit_ref'
the list of possible "FlagBits" is stored in 'vorgaben_flagbit'
(optional) for returning a name for the "FlagBit" you can use the names of the constants from the
const.php.

API Endpoint: GET

/api/flagbits.php?apikey=8067562d7138d72501485941246cf9b229c3a46a&trans_id=2

Step 5
There should be an API endpoint to set (enable) a specific "FlagBit" to some transaction.
This endpoint should be limited to access tokens which have the value 'ist_masterkey' set to 1.
Step 6 (optional)
There should be an API endpoint to remove (disable) a specific "FlagBit" to some transaction.
This endpoint should be limited to access tokens which have the value 'ist_masterkey' set to 1.

Step 7 (optional)
There should be some API endpoint to get the history of the "FlagBits" for some transaction

API Endpoint: GET

/api/transaction/flagbits.php?access_token=8067562d7138d72501485941246cf9b229c3a46a&trans_id=1

{
  "transaction_id": "1",
  "flagbits": [
    {
      "flagbit_ref_id": 100,
      "datensatz_typ_id": 2,
      "datensatz_id": 1,
      "flagbit": 4,
      "zeitraum_id": 1,
      "bearbeiter_id": 2,
      "timestamp": "2020-10-01 12:05:00",
      "flagbit_description": "0 = XML, 1 = iFrame"
    }
  ]
}












https://chatgpt.com/c/681b70c2-c8f8-8010-bf1c-b3b2823e7aec

https://chatgpt.com/c/681a35e3-edc0-8010-abf9-e3e331fab801




https://chatgpt.com/c/681b95c8-0fe4-8010-be1e-54f778807a01

Step: 4
API Endpoint : api/flagbits.php

{
  "error": "apikey and trans_id required"
}


flagbits
http://localhost/interview/secupayag/api/flagbits.php?apikey=8067562d7138d72501485941246cf9b229c3a46a&trans_id=2

{
  "flagbits": [
    {
      "id": 4,
      "name": "TRANSACTION_FLAG_EXT_API"
    }
  ]
}

http://localhost/interview/secupayag/api/flagbits.php?apikey=8067562d7138d72501485941246cf9b229c3a46a&trans_id=1


{
  "error": "Access denied to this transaction"
}

http://localhost/interview/secupayag/api/flagbits.php?apikey=8067562d7138d72501485941246cf9b229c3a46a&trans_id=3

{
  "error": "Access denied to this transaction"
}


Step 5

http://localhost/interview/secupayag/api/setTransactionFlagBit.php?Authorization=8067562d7138d72501485941246cf9b229c3a46a&trans_id=3&flagbit=12

Step 6

https://chatgpt.com/c/681cc40a-8cc0-8010-98c3-d927bbb21764


Step 7 
https://chatgpt.com/c/681cbca0-a22c-8010-ad3c-a7f5054c39e2