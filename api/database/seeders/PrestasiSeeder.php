<?php
namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Prestasi;
use App\Models\Sekolah;
use Faker\Factory as Faker;

class PrestasiSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create('id_ID');
        $sekolahList = Sekolah::all();
        
        $judulPrestasi = [
            'Juara 1 Lomba Matematika Tingkat Kota',
            'Juara 2 Olimpiade Fisika Nasional',
            'Juara 3 Kompetisi Debat Bahasa Inggris',
            'Juara 1 Festival Band Sekolah',
            'Juara 2 Lomba Puisi Nasional',
            'Juara 1 Kompetisi Robotika',
            'Juara 3 Lomba Karya Tulis Ilmiah'
        ];

        $counter = 0;
        foreach ($sekolahList as $sekolah) {
            
            foreach ($judulPrestasi as $judul) {
                Prestasi::create([
                    'id_sekolah' => $sekolah->id_sekolah,
                    'judul' => $judul,
                    'deskripsi' => $faker->paragraph(),
                    'tanggal' => $faker->dateTimeBetween('-1 year', 'now'),
                ]);
                $counter++;
            }
        }

        $this->command->info("✅ {$counter} Prestasi berhasil dibuat!");
    }
}