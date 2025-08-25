<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Artikel;
use App\Models\Sekolah;
use Faker\Factory as Faker;

class ArtikelSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create('id_ID');
        $sekolahList = Sekolah::all();
        
        $judulArtikel = [
            'Kegiatan Bakti Sosial Siswa SMA',
            'Prestasi Gemilang dalam Lomba Futsal',
            'Seminar Parenting untuk Orang Tua',
            'Upacara Peringatan Hari Kemerdekaan',
            'Sosialisasi SNPMB untuk Siswa Kelas XII',
            'Pentas Seni Akhir Tahun Ajaran',
            'Lomba Mancing Tingkat Kota',
            'Olimpiade Matematika Nasional'
        ];

        $gambarArtikel = [
            'bakti_sosial.jpeg',
            'lomba_futsal.jpeg', 
            'seminar_parenting.jpeg',
            'upacara_kemerdekaan.jpeg',
            'sosialisasi_snpmb.jpeg',
            'pentas_seni.jpeg',
            'lomba_mancing.jpg',
            'lomba_matematika.jpg'
        ];

        $counter = 0;
        foreach ($sekolahList as $sekolah) {
            for ($i = 0; $i < count($judulArtikel); $i++) {
                Artikel::create([
                    'id_sekolah' => $sekolah->id_sekolah,
                    'judul' => $judulArtikel[$i],
                    'isi' => $faker->paragraphs(3, true),
                    'tanggal' => $faker->dateTimeBetween('-3 months', 'now'),
                    'gambar' => $gambarArtikel[$i],
                ]);
                $counter++;
            }
        }

        $this->command->info("✅ {$counter} Artikel berhasil dibuat!");
    }
}