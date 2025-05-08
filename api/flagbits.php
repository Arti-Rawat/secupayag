<?php

require_once 'const.php';
require_once 'db.php'; // assumes $pdo is PDO instance

//$pdo = new PDO('mysql:host=localhost;dbname=secupay', 'root', '');
//$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

header('Content-Type: application/json');

// 1. Get and validate input
$apikey = $_GET['apikey'] ?? '';
$trans_id = intval($_GET['trans_id'] ?? 0);

if (!$apikey || !$trans_id) {
    http_response_code(400);
    echo json_encode(['error' => 'apikey and trans_id required']);
    exit;
}

// 2. Validate API key
$stmt = $pdo->prepare("
    SELECT a.vertrag_id, z.von, z.bis 
    FROM api_apikey a
    JOIN vorgaben_zeitraum z ON a.zeitraum_id = z.zeitraum_id
    WHERE a.apikey = ?
");
$stmt->execute([$apikey]);
$api = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$api) {
    http_response_code(403);
    echo json_encode(['error' => 'Invalid API key']);
    exit;
}

$now = date('Y-m-d H:i:s');
if ($now < $api['von'] || $now > $api['bis']) {
    http_response_code(403);
    echo json_encode(['error' => 'API key expired or not yet valid']);
    exit;
}

// 3. Check if transaction belongs to API key's vertrag_id
$stmt = $pdo->prepare("
    SELECT * FROM transaktion_transaktionen
    WHERE trans_id = ? AND vertrag_id = ?
");
$stmt->execute([$trans_id, $api['vertrag_id']]);
$transaction = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$transaction) {
    http_response_code(403);
    echo json_encode(['error' => 'Access denied to this transaction']);
    exit;
}

// 4. Fetch active FlagBits from stamd_flagbit_ref (datensatz_typ_id 2 = Transaktion)
$stmt = $pdo->prepare("
    SELECT flagbit 
    FROM stamd_flagbit_ref sfr
    JOIN vorgaben_zeitraum vz ON sfr.zeitraum_id = vz.zeitraum_id
    WHERE sfr.datensatz_typ_id = 2 
    AND sfr.datensatz_id = ? 
    AND ? BETWEEN vz.von AND vz.bis
");
$stmt->execute([$trans_id, $now]);
$flagbits = $stmt->fetchAll(PDO::FETCH_COLUMN);

if (!$flagbits) {
    echo json_encode(['flagbits' => []]);
    exit;
}

// 5. Map flagbit ids to const names using reflection
$reflection = new ReflectionClass('DataFlag');
$consts = array_flip($reflection->getConstants());

$flagbitList = [];
foreach ($flagbits as $flagbit) {
    $flagbitList[] = [
        'id' => $flagbit,
        'name' => $consts[$flagbit] ?? 'UNKNOWN'
    ];
}

// 6. Output result
echo json_encode(['flagbits' => $flagbitList]);
