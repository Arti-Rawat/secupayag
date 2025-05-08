<?php
// DB config
$dbHost = 'localhost';
$dbName = 'secupay';
$dbUser = 'root';
$dbPass = '';

header('Content-Type: application/json');

// Get Authorization header
$headers = getallheaders();
if (!isset($headers['Authorization']) || !preg_match('/Bearer\s(\S+)/', $headers['Authorization'], $matches)) {
    http_response_code(401);
    echo json_encode(['error' => 'Missing or invalid Authorization header.']);
    exit;
}

$apiKey = $matches[1];

try {
    $pdo = new PDO("mysql:host=$dbHost;dbname=$dbName;charset=utf8", $dbUser, $dbPass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Validate API key
    $stmt = $pdo->prepare("
        SELECT a.zeitraum_id, z.von, z.bis 
        FROM api_apikey a
        JOIN vorgaben_zeitraum z ON a.zeitraum_id = z.zeitraum_id
        WHERE a.apikey = :apikey
        LIMIT 1
    ");
    $stmt->execute(['apikey' => $apiKey]);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$data) {
        http_response_code(403);
        echo json_encode(['error' => 'Invalid API key.']);
        exit;
    }

    $now = new DateTime();
    $von = new DateTime($data['von']);
    $bis = new DateTime($data['bis']);

    if ($now < $von || $now > $bis) {
        http_response_code(403);
        echo json_encode(['error' => 'API key expired or not yet valid.']);
        exit;
    }

    // Valid key, return server time
    echo json_encode([
        'server_time' => $now->format('Y-m-d H:i:s')
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
