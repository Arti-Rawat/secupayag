<?php
header('Content-Type: application/json');

// Database config
$host = 'localhost';
$db = 'secupay';
$user = 'root';
$pass = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Check for API key in Authorization header
    $headers = apache_request_headers();
    $authHeader = isset($headers['Authorization']) ? $headers['Authorization'] : '';

    if (!$authHeader || !preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
        http_response_code(401);
        echo json_encode(['error' => 'Unauthorized: Missing or invalid Authorization header']);
        exit;
    }

    $apiKey = $matches[1];

    // Validate API key and check active zeitraum
    $stmt = $pdo->prepare("
        SELECT a.apikey_id 
        FROM api_apikey a
        INNER JOIN vorgaben_zeitraum z ON z.zeitraum_id = a.zeitraum_id
        WHERE a.apikey = :apikey AND NOW() BETWEEN z.von AND z.bis
        LIMIT 1
    ");
    $stmt->execute(['apikey' => $apiKey]);

    if ($stmt->rowCount() === 0) {
        http_response_code(403);
        echo json_encode(['error' => 'Forbidden: Invalid or expired API key']);
        exit;
    }

    // Return current server time
    echo json_encode([
        'server_time' => date('Y-m-d H:i:s')
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Server error: ' . $e->getMessage()]);
}
?>
