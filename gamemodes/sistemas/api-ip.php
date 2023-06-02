<?php

$ip = $_SERVER['REMOTE_ADDR']; // Obtém o endereço IP do cliente

// Faz uma solicitação à API do ip-api.com para obter informações sobre o IP
$response = file_get_contents("http://ip-api.com/json/$ip");

// Verifica se a resposta da API foi bem-sucedida
if ($response !== false) {
    $data = json_decode($response, true);

    // Obtém as informações desejadas do resultado
    $provider = $data['isp'];
    $country = $data['country'];

    // Imprime as informações na página
    echo "Provedor de Internet: " . $provider . "<br>";
    echo "País: " . $country;
} else {
    echo "Não foi possível obter as informações do IP.";
}

?>
