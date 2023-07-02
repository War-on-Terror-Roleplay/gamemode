<?php

function getIPDetails($ip) {
    $url = "http://ip-api.com/json/{$ip}?fields=isp,country";
    
    $response = file_get_contents($url);
    
    if ($response) {
        $data = json_decode($response, true);
        return $data;
    }
    
    return null;
}

// Exemplo de uso
$ip = $_SERVER['REMOTE_ADDR']; // IP do cliente que acessou a página
$details = getIPDetails($ip);

if ($details && $details['status'] === 'success') {
    $provedor = $details['isp'];
    $pais = $details['country'];
    
    echo "Provedor: {$provedor}<br>";
    echo "País: {$pais}";
} else {
    echo "Não foi possível obter os detalhes do IP.";
}
?>
