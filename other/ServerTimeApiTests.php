<?php
use PHPUnit\Framework\TestCase;

class ServerTimeApiTests extends TestCase
{
    private $apiUrl = 'http://localhost/interview/secupayag/api/server_time.php';

    private $validApiKey = '9faa37b23f350c516e3589e60083d10cd368df01'; // Replace with a real one
    private $invalidApiKey = 'invalidapikey1234567890';

    private function getApiResponse(string $apiKey = null): array
    {
        $headers = [];
        if ($apiKey) {
            $headers[] = "Authorization: Bearer $apiKey";
        }

        $opts = [
            "http" => [
                "method" => "GET",
                "header" => implode("\r\n", $headers)
            ]
        ];
        $context = stream_context_create($opts);
        $response = @file_get_contents($this->apiUrl, false, $context);

        $httpCode = null;
        if (isset($http_response_header)) {
            foreach ($http_response_header as $header) {
                if (preg_match('#HTTP/\d\.\d\s+(\d+)#', $header, $matches)) {
                    $httpCode = (int)$matches[1];
                    break;
                }
            }
        }

        if ($response === false) {
            $response = ''; // Prevent null errors
        }

        return [
            'response' => $response,
            'json' => json_decode($response, true),
            'http_code' => $httpCode,
        ];
    }

    public function testWithoutApiKey()
    {
        $result = $this->getApiResponse();

        $this->assertSame(401, $result['http_code'], 'Expected 401 Unauthorized');
        $this->assertStringContainsString('Unauthorized', $result['response'] ?? '', 'Expected Unauthorized message');
    }

    public function testWithInvalidApiKey()
    {
        $result = $this->getApiResponse($this->invalidApiKey);

        $this->assertSame(403, $result['http_code'], 'Expected 403 Forbidden');
        $this->assertStringContainsString('Forbidden', $result['response'] ?? '', 'Expected Forbidden message');
    }

    public function testWithValidApiKey()
    {
        $result = $this->getApiResponse($this->validApiKey);

        $this->assertSame(200, $result['http_code'], "HTTP Code was not 200");
        $this->assertIsArray($result['json'], "Response is not valid JSON");
        $this->assertArrayHasKey('server_time', $result['json']);
    }
}
