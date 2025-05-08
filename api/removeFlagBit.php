<?php

require_once 'db.php'; // Your DB connection
require_once 'const.php'; // DataFlag constants

function validate_token($token, $db) {
    $stmt = $db->prepare("SELECT * FROM api_apikey WHERE apikey = ?");
    $stmt->execute([$token]);
    $apikey = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$apikey) return false;

    $zeitraumStmt = $db->prepare("SELECT * FROM vorgaben_zeitraum WHERE zeitraum_id = ?");
    $zeitraumStmt->execute([$apikey['zeitraum_id']]);
    $zeitraum = $zeitraumStmt->fetch(PDO::FETCH_ASSOC);

    if (!$zeitraum) return false;

    $now = date('Y-m-d H:i:s');
    if ($zeitraum['von'] > $now || $zeitraum['bis'] < $now) return false;

    if ($apikey['ist_masterkey'] != 1) return false;

    return true;
}

function remove_flagbit($trans_id, $flagbit, $db) {
    $stmt = $db->prepare("DELETE FROM stamd_flagbit_ref 
                          WHERE datensatz_typ_id = 2 
                          AND datensatz_id = ? 
                          AND flagbit = ?");
    return $stmt->execute([$trans_id, $flagbit]);
}

// ----- Entry Point -----
$headers = getallheaders();
$token = str_replace('Bearer ', '', $headers['Authorization'] ?? '');

$data = json_decode(file_get_contents('php://input'), true);
$trans_id = $data['trans_id'] ?? null;
$flagbit = $data['flagbit'] ?? null;

if (!$token || !$trans_id || !$flagbit) {
    http_response_code(400);
    echo json_encode(["error" => "Missing required data"]);
    exit;
}

try {
    $db = new PDO('mysql:host=localhost;dbname=secupay', 'root', '');
    if (!validate_token($token, $db)) {
        http_response_code(403);
        echo json_encode(["error" => "Unauthorized or token expired"]);
        exit;
    }

    $success = remove_flagbit($trans_id, $flagbit, $db);
    if ($success) {
        echo json_encode(["success" => true, "message" => "FlagBit removed"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => "Could not remove FlagBit"]);
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Server error", "details" => $e->getMessage()]);
}
