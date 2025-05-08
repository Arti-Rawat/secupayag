<?php

$ch = curl_init('http://localhost/interview/secupayag/api/removeFlagBit');
$data = ['trans_id' => 3, 'flagbit' => 12];
$headers = [
    'Content-Type: application/json',
    'Authorization: Bearer 8067562d7138d72501485941246cf9b229c3a46a'
];

curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

$response = curl_exec($ch);
curl_close($ch);

echo $response;
