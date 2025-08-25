<?php

// database/seeders/AkunSeeder.php
namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Akun;
use App\Models\Guru;
use App\Models\Siswa;
use Illuminate\Support\Facades\Hash;

class AkunSeeder extends Seeder
{
    public function run(): void
    {
        // Admin account
        Akun::create([
            'username' => 'admin',
            'password' => Hash::make('password'),
            'role' => 'admin',
            'id_guru' => null,
            'id_siswa' => null,
        ]);

        // Guru accounts
        $guruList = Guru::all();
        foreach ($guruList as $guru) {
            $username = strtolower(str_replace([' ', '.', ','], '', explode(' ', $guru->nama_guru)[0]));
            Akun::create([
                'username' => $username . $guru->id_guru,
                'password' => Hash::make('guru123'),
                'role' => 'guru',
                'id_guru' => $guru->id_guru,
                'id_siswa' => null,
            ]);
        }

        // Siswa accounts (ambil 20 siswa pertama saja untuk sample)
        $siswaList = Siswa::limit(20)->get();
        foreach ($siswaList as $siswa) {
            $username = strtolower(str_replace(' ', '', explode(' ', $siswa->nama_siswa)[0]));
            Akun::create([
                'username' => $username . $siswa->nisn,
                'password' => Hash::make('siswa123'),
                'role' => 'siswa',
                'id_guru' => null,
                'id_siswa' => $siswa->id_siswa,
            ]);
        }

        $totalAkun = 1 + count($guruList) + 20;
        $this->command->info("✅ {$totalAkun} Akun berhasil dibuat!");
    }
}