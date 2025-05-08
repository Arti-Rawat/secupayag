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

API Endpoint: Post
/api/setTransactionFlagBit.php?Authorization=8067562d7138d72501485941246cf9b229c3a46a&trans_id=3&flagbit=12

Step 6 (optional)
There should be an API endpoint to remove (disable) a specific "FlagBit" to some transaction.
This endpoint should be limited to access tokens which have the value 'ist_masterkey' set to 1.

API Endpoint: Post
/api/removeFlagBit.php?trans_id=3&flagbit=12&Authorization=8067562d7138d72501485941246cf9b229c3a46a

Step 7 (optional)
There should be some API endpoint to get the history of the "FlagBits" for some transaction

API Endpoint: GET

/api/transaction/flagbits.php?access_token=8067562d7138d72501485941246cf9b229c3a46a&trans_id=1
