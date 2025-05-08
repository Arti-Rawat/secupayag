<?php
require_once 'db.php'; //  DB connection
require_once 'const.php';

// Fetch inputs
$headers = getallheaders();
$accessToken = $headers['Authorization'] ?? '';
$transId = $_POST['trans_id'] ?? null;
$flagBit = $_POST['flagbit'] ?? null;

if (!$accessToken || !$transId || !$flagBit) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing parameters']);
    exit;
}

// Validate token
$stmt = $pdo->prepare("
    SELECT a.*, z.von, z.bis
    FROM api_apikey a
    JOIN vorgaben_zeitraum z ON a.zeitraum_id = z.zeitraum_id
    WHERE a.apikey = :token
    AND a.ist_masterkey = 1
    LIMIT 1
");
$stmt->execute(['token' => $accessToken]);
$apikeyData = $stmt->fetch(PDO::FETCH_ASSOC);

// Check if token is valid and active
$now = date('Y-m-d H:i:s');
if (!$apikeyData || $now < $apikeyData['von'] || $now > $apikeyData['bis']) {
    http_response_code(403);
    echo json_encode(['error' => 'Invalid or inactive token']);
    exit;
}

// Validate transaction exists
$transCheck = $pdo->prepare("SELECT * FROM transaktion_transaktionen WHERE trans_id = ?");
$transCheck->execute([$transId]);
if (!$transCheck->fetch()) {
    http_response_code(404);
    echo json_encode(['error' => 'Transaction not found']);
    exit;
}

// Insert into flagbit_ref
$insert = $pdo->prepare("
    INSERT INTO stamd_flagbit_ref 
    (datensatz_typ_id, datensatz_id, flagbit, zeitraum_id, bearbeiter_id, timestamp)
    VALUES (2, :trans_id, :flagbit, :zeitraum_id, :bearbeiter_id, :ts)
");
$insert->execute([
    'trans_id' => $transId,
    'flagbit' => $flagBit,
    'zeitraum_id' => $apikeyData['zeitraum_id'],
    'bearbeiter_id' => $apikeyData['bearbeiter_id'],
    'ts' => $now,
]);

echo json_encode(['success' => true, 'message' => 'Flagbit set successfully']);
