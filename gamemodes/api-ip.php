<?php

$ip = $_SERVER['REMOTE_ADDR']; // Obt�m o endere�o IP do cliente

// Faz uma solicita��o � API de terceiros para obter informa��es sobre o IP
$response = file_get_contents("http://api.external-service.com/ip/$ip");e

// Verifica se a resposta da API foi bem-sucedida
if ($response !== false) {
    $data = json_decode($response, true);

    // Obt�m as informa��es desejadas do resultado
    $provider = $data['provider'];
    $country = $data['country'];

    // Imprime as informa��es no console
    echo "Provedor de Internet:" . $provider;
    echo "Pa�s:" . $country;
} else {
    echo "N�o foi poss�vel obter as informa��es do IP.";
}

?>