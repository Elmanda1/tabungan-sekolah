<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Jurusan;
use App\Models\Sekolah;

class JurusanSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $sekolahList = Sekolah::all();
        
        $jurusanData = [
            'MIPA',
            'IPS', 
            'Bahasa'
        ];

        foreach ($sekolahList as $sekolah) {
            foreach ($jurusanData as $namaJurusan) {
                Jurusan::create([
                    'id_sekolah' => $sekolah->id_sekolah,
                    'nama_jurusan' => $namaJurusan,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        $totalJurusan = count($sekolahList) * count($jurusanData);
        $this->command->info("✅ {$totalJurusan} Jurusan berhasil dibuat!");
    }
}