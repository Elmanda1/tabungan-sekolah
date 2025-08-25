<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\JenisKelas;

class JenisKelasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $jenisKelasData = [
            ['nama_jenis_kelas' => 'X'],
            ['nama_jenis_kelas' => 'XI'],  
            ['nama_jenis_kelas' => 'XII'],
        ];

        foreach ($jenisKelasData as $data) {
            JenisKelas::create($data);
        }

        $this->command->info('✅ 3 Jenis Kelas berhasil dibuat!');
    }
}