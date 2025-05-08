<?php

require __DIR__ . '/../vendor/autoload.php'; //add for autoloader : So that can use PHPUnit


use PHPUnit\Framework\TestCase;

class ServerTimeApiTest extends TestCase
{
    private $validToken = '9faa37b23f350c516e3589e60083d10cd368df01'; // For ApiKey or Token
    private $invalidToken = 'invalidtoken123';

    public function testValidTokenReturnsTime()
    {
        $response = $this->makeRequest($this->validToken, $status);
        $this->assertEquals(200, $status, "Expected 200 OK, got $status");
        
        $data = json_decode($response, true);
        $this->assertNotNull($data, "Response is not valid JSON: $response");
    
        $this->assertArrayHasKey('server_time', $data);
        $this->assertMatchesRegularExpression('/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/', $data['server_time']);
    }
    

    public function testInvalidTokenReturnsUnauthorized()
    {
        $response = $this->makeRequest($this->invalidToken, $status);
        $this->assertEquals(401, $status, "Expected 401 Unauthorized, got $status");
    
        $data = json_decode($response, true);
        $this->assertNotNull($data, "Response is not valid JSON: $response");
        $this->assertEquals('Unauthorized - Token invalid', $data['error']);

    }
    

    private function makeRequest($token = '', &$statusCode = null)
    {
        $ch = curl_init('http://localhost/interview/secupayag/getServerTime.php');
        
        if ($token) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, ['Authorization: Bearer ' . $token]);
        }
    
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, true);
        $response = curl_exec($ch);
        
        if ($response === false) {
            throw new \RuntimeException('Curl error: ' . curl_error($ch));
        }
    
        $headerSize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $statusCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
    
        $body = substr($response, $headerSize);
    
        // Debug output in case of test failure
        fwrite(STDERR, "\n[HTTP $statusCode] Response: $body\n");
    
        return $body;
    }
    
}
