<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Galeri;
use App\Models\Sekolah;

class GaleriSeeder extends Seeder
{
    public function run(): void
    {
        $sekolahList = Sekolah::all();
        
        $galeriData = [
            [
                'judul' => 'Kegiatan Ekstrakurikuler Basket',
                'deskripsi' => 'Latihan rutin ekstrakurikuler basket setiap hari Selasa dan Kamis',
                'gambar' => 'club_basket_fix.png'
            ],
            [
                'judul' => 'Tim Sepak Bola Sekolah',
                'deskripsi' => 'Tim sepak bola sekolah yang berprestasi di tingkat kota',
                'gambar' => 'club_bola.png'
            ],
            [
                'judul' => 'Ekstrakurikuler Hockey',
                'deskripsi' => 'Kegiatan ekstrakurikuler hockey yang diminati siswa',
                'gambar' => 'club_hockey.png'
            ],
            [
                'judul' => 'Ulang Tahun Sekolah',
                'deskripsi' => 'Perayaan ulang tahun sekolah dengan berbagai kegiatan menarik',
                'gambar' => 'ulang_tahun.jpeg'
            ]
        ];

        $counter = 0;
        foreach ($sekolahList as $sekolah) {
            foreach ($galeriData as $data) {
                Galeri::create([
                    'id_sekolah' => $sekolah->id_sekolah,
                    'judul' => $data['judul'],
                    'deskripsi' => $data['deskripsi'],
                    'gambar' => $data['gambar'],
                ]);
                $counter++;
            }
        }

        $this->command->info("✅ {$counter} Galeri berhasil dibuat!");
    }
}