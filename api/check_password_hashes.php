<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';

$kernel = $app->make(Illware_Contracts_Http_Kernel::class);

$response = $kernel->handle(
    $request = Illuminate\Http\Request::capture()
);

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

// Connect to the database
$pdo = DB::connection()->getPdo();

// Get all siswa accounts
$accounts = DB::table('akun')
    ->where('role', 'siswa')
    ->get(['id', 'username', 'password']);

echo "Checking password hashes for siswa accounts...\n";
$matchCount = 0;
$totalCount = count($accounts);

foreach ($accounts as $account) {
    $isMatch = Hash::check('siswa123', $account->password);
    
    if ($isMatch) {
        $matchCount++;
        echo "[MATCH] ID: {$account->id}, Username: {$account->username}\n";
    } else {
        echo "[NO MATCH] ID: {$account->id}, Username: {$account->username}\n";
    }
}

echo "\nSummary:\n";
echo "Total siswa accounts: $totalCount\n";
echo "Accounts with password 'siswa123': $matchCount\n";

$response->send();

$kernel->terminate($request, $response);
