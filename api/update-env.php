<?php

$envPath = __DIR__ . '/.env';

// Read the current .env file
$envContent = file_get_contents($envPath);

// Update session and cache settings
$updates = [
    'SESSION_DRIVER=file' => 'SESSION_DRIVER=file',
    'CACHE_STORE=file' => 'CACHE_STORE=file',
    'SESSION_DRIVER=database' => 'SESSION_DRIVER=file',
    'CACHE_STORE=database' => 'CACHE_STORE=file',
];

foreach ($updates as $search => $replace) {
    $envContent = str_replace($search, $replace, $envContent);
}

// Add settings if they don't exist
if (strpos($envContent, 'SESSION_DRIVER=') === false) {
    $envContent .= "\nSESSION_DRIVER=file";
}
if (strpos($envContent, 'CACHE_STORE=') === false) {
    $envContent .= "\nCACHE_STORE=file";
}

// Write back to .env
file_put_contents($envPath, $envContent);

echo "Environment file updated successfully.\n";
