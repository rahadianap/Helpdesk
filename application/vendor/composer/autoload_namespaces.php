<?php


$vendorDir = dirname(dirname(__FILE__));
$baseDir = dirname($vendorDir);

return array(
    'PayPal' => array($vendorDir . '/paypal/rest-api-sdk-php/lib'),
    'Less' => array($vendorDir . '/oyejorge/less.php/lib'),
    'JShrink' => array($vendorDir . '/tedivm/jshrink/src'),
    'Hybrid' => array($vendorDir . '/hybridauth/hybridauth/hybridauth'),
);
