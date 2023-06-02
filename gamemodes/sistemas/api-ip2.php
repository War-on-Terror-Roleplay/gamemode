<?php
if (!isset($_GET["ip"]) or $_GET["ip"] == "") {
    echo "fail";
}

$ip = $_GET["ip"];

$curl = curl_init();

curl_setopt_array($curl, array(
    CURLOPT_URL => "http://ip-api.com/json/" . $ip . "?fields=status,country",
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT => 30,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => "GET",
    CURLOPT_HTTPHEADER => array(
        "cache-control: no-cache"
    ),
));

$response = curl_exec($curl);

$response = json_decode($response, true);

if ($response["status"] == "success") {
    http_response_code(200);
    echo $response["country"];
} else {
    echo "fail";
}

curl_close($curl);

?>