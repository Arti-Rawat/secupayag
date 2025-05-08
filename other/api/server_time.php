<?php
header('Content-Type: application/json');

// Simulate database config
$pdo = new PDO('mysql:host=localhost;dbname=secupay;charset=utf8', 'root', '');

// Get Authorization header
function getBearerToken() {
    $headers = [];
    if (function_exists('getallheaders')) {
        $headers = getallheaders();
    } elseif (isset($_SERVER['HTTP_AUTHORIZATION'])) {
        $headers['Authorization'] = $_SERVER['HTTP_AUTHORIZATION'];
    }

    if (isset($headers['Authorization']) && str_starts_with($headers['Authorization'], 'Bearer ')) {
        return trim(substr($headers['Authorization'], 7));
    }

    return null;
}

$token = getBearerToken();

if (!$token) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

// Validate token
$sql = "SELECT a.apikey_id FROM api_apikey a
        INNER JOIN vorgaben_zeitraum v ON v.zeitraum_id = a.zeitraum_id
        WHERE a.apikey = :apikey AND NOW() BETWEEN v.von AND v.bis LIMIT 1";
$stmt = $pdo->prepare($sql);
$stmt->execute(['apikey' => $token]);

if (!$stmt->fetch()) {
    http_response_code(403);
    echo json_encode(['error' => 'Forbidden']);
    exit;
}

// Success
http_response_code(200);
echo json_encode(['server_time' => date('Y-m-d H:i:s')]);
