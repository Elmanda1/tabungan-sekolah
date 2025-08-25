<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';

$kernel = $app->make(Ill\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\Hash;

$password = 'siswa123';
$hash = '$2y$12$l5IiWcrwDcYldxlNNPOT3uaaegPgU3cxlCW/2ykIL/4QBEgRTMUmu';

$check = Hash::check($password, $hash);

echo "Password: $password\n";
echo "Hash: $hash\n";
echo "Check result: " . ($check ? '✅ Match' : '❌ No match') . "\n";

// Also check if the password is being hashed correctly
$newHash = Hash::make($password);
echo "\nNew hash for '$password': $newHash\n";
echo "Check new hash: " . (Hash::check($password, $newHash) ? '✅ Valid' : '❌ Invalid') . "\n";
