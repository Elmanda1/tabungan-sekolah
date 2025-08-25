<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Mapel;
use App\Models\Sekolah;

class MapelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $sekolahList = Sekolah::all();
        
        $mapelData = [
            [
                'nama_mapel' => 'Matematika',
            ],
            [
                'nama_mapel' => 'Bahasa Indonesia', 
            ],
            [
                'nama_mapel' => 'Bahasa Inggris',
            ],
            [
                'nama_mapel' => 'Fisika',
            ],
            [
                'nama_mapel' => 'Kimia',
            ],
            [
                'nama_mapel' => 'Biologi',
            ],
            [
                'nama_mapel' => 'Sejarah',
            ],
            [
                'nama_mapel' => 'Geografi',
            ],
            [
                'nama_mapel' => 'Ekonomi',
            ],
            [
                'nama_mapel' => 'Sosiologi',
            ]
        ];

        foreach ($sekolahList as $sekolah) {
            foreach ($mapelData as $mapel) {
                Mapel::create([
                    'id_sekolah' => $sekolah->id_sekolah,
                    'nama_mapel' => $mapel['nama_mapel'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }

        $totalMapel = count($sekolahList) * count($mapelData);
        $this->command->info("✅ {$totalMapel} Mata Pelajaran berhasil dibuat!");
    }
}