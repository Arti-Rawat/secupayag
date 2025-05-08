<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


require_once 'db.php';
require_once 'auth.php';

header('Content-Type: application/json');

// Allow Authorization header to pass through Apache
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header('Access-Control-Allow-Headers: Authorization');
    exit(0);
}

// Get the Bearer token from the Authorization header
$headers = getallheaders();
$accessToken = '';

if (isset($headers['Authorization'])) {
    $accessToken = trim(str_replace('Bearer ', '', $headers['Authorization']));
} elseif (isset($headers['authorization'])) { // sometimes lowercase
    $accessToken = trim(str_replace('Bearer ', '', $headers['authorization']));
}

if (empty($accessToken)) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized - Token missing']);
    exit;
}

if (!isValidToken($accessToken)) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized - Token invalid']);
    exit;
}

http_response_code(200);
echo json_encode(['server_time' => date('Y-m-d H:i:s')]);
