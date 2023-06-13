<?php

$ip = $_SERVER['REMOTE_ADDR']; // Obtém o endereço IP do cliente

// Faz uma solicitação à API de terceiros para obter informações sobre o IP
$response = file_get_contents("http://api.external-service.com/ip/$ip");e

// Verifica se a resposta da API foi bem-sucedida
if ($response !== false) {
    $data = json_decode($response, true);

    // Obtém as informações desejadas do resultado
    $provider = $data['provider'];
    $country = $data['country'];

    // Imprime as informações no console
    echo "Provedor de Internet:" . $provider;
    echo "País:" . $country;
} else {
    echo "Não foi possível obter as informações do IP.";
}

?>