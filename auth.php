<?php

function isValidToken($token) {
    require 'db.php';

    $stmt = $pdo->prepare("SELECT zeitraum.von, zeitraum.bis 
        FROM api_apikey AS api
        JOIN vorgaben_zeitraum AS zeitraum ON api.zeitraum_id = zeitraum.zeitraum_id
        WHERE api.apikey = ?");
    $stmt->execute([$token]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) return false;

    $now = date('Y-m-d H:i:s');
    return $row['von'] <= $now && $now <= $row['bis'];
}
