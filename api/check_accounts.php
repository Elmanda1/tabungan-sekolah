<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';

$kernel = $app->make(Illware\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

// Check the admin account
$admin = DB::table('tb_akun')->where('username', 'admin')->first();
if ($admin) {
    echo "Admin account found!\n";
    echo "Username: " . $admin->username . "\n";
    echo "Password hash: " . $admin->password . "\n";
    echo "Password check (siswa123): " . (Hash::check('siswa123', $admin->password) ? '✅' : '❌') . "\n";
    echo "Password check (password): " . (Hash::check('password', $admin->password) ? '✅' : '❌') . "\n\n";
} else {
    echo "Admin account not found!\n\n";
}

// Check the ridwan1001 account
$ridwan = DB::table('tb_akun')->where('username', 'ridwan1001')->first();
if ($ridwan) {
    echo "Ridwan account found!\n";
    echo "Username: " . $ridwan->username . "\n";
    echo "Password hash: " . $ridwan->password . "\n";
    echo "Password check (siswa123): " . (Hash::check('siswa123', $ridwan->password) ? '✅' : '❌') . "\n";
    echo "ID Siswa: " . $ridwan->id_siswa . "\n";
    
    // Check if the student exists
    $siswa = DB::table('tb_siswa')->where('id_siswa', $ridwan->id_siswa)->first();
    if ($siswa) {
        echo "Student found: " . $siswa->nama_siswa . " (NISN: " . $siswa->nisn . ")\n";
    } else {
        echo "Student record not found for ID: " . $ridwan->id_siswa . "\n";
    }
} else {
    echo "Ridwan account not found!\n";
    
    // List some available accounts
    echo "\nAvailable accounts (first 5):\n";
    $accounts = DB::table('tb_akun')->take(5)->get();
    foreach ($accounts as $account) {
        echo "- " . $account->username . " (Role: " . $account->role . ")\n";
    }
}
