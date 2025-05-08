<?php

// api/transaction/flagbits.php

header('Content-Type: application/json');

// === Connect to DB ===
require_once '../db.php'; // Your PDO connection here
require_once '../const.php';      // Your DataFlag class constants

$token = $_GET['access_token'] ?? '';
$trans_id = $_GET['trans_id'] ?? '';

if (empty($token) || empty($trans_id)) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing required parameters']);
    exit;
}

$apiUser = validateAccessToken($token, $pdo);
$data = getFlagBitHistory($trans_id, $pdo);


function getFlagBitHistory($trans_id, $pdo)
{
    $stmt = $pdo->prepare("
        SELECT sfr.*, vf.beschreibung AS flagbit_description
        FROM stamd_flagbit_ref sfr
        JOIN vorgaben_flagbit vf ON sfr.flagbit = vf.flagbit_id
        WHERE sfr.datensatz_typ_id = 2 AND sfr.datensatz_id = ?
        ORDER BY sfr.timestamp ASC
    ");
    $stmt->execute([$trans_id]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}


function validateAccessToken($token, $pdo)
{
    $stmt = $pdo->prepare("
        SELECT aa.*, vz.von, vz.bis 
        FROM api_apikey aa
        JOIN vorgaben_zeitraum vz ON aa.zeitraum_id = vz.zeitraum_id
        WHERE aa.apikey = ?
    ");
    $stmt->execute([$token]);
    $api = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$api) {
        http_response_code(401);
        echo json_encode(['error' => 'Invalid API key']);
        exit;
    }

    $now = new DateTime();
    $von = new DateTime($api['von']);
    $bis = new DateTime($api['bis']);

    if ($now < $von || $now > $bis) {
        http_response_code(403);
        echo json_encode(['error' => 'API key expired or not yet valid']);
        exit;
    }

    return $api; // valid token details
}


echo json_encode(['transaction_id' => $trans_id, 'flagbits' => $data]);
