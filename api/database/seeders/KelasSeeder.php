<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Kelas;
use App\Models\Sekolah;
use App\Models\Jurusan;
use App\Models\JenisKelas;
use App\Models\Guru;

class KelasSeeder extends Seeder
{
    public function run(): void
    {
        $sekolahList = Sekolah::all();
        $jenisKelasList = JenisKelas::all();
        $counter = 0;

        foreach ($sekolahList as $sekolah) {
            $jurusanList = Jurusan::where('id_sekolah', $sekolah->id_sekolah)->get();
            $guruList = Guru::where('id_sekolah', $sekolah->id_sekolah)->get();
            $guruIndex = 0;

            foreach ($jenisKelasList as $jenisKelas) {
                foreach ($jurusanList as $jurusan) {
                    // Buat 2 kelas per jurusan per tingkat (misal: X IPA 1, X IPA 2)
                    for ($i = 1; $i <= 2; $i++) {
                        $waliKelas = $guruList[$guruIndex % count($guruList)];
                        
                        Kelas::create([
                            'id_sekolah' => $sekolah->id_sekolah,
                            'id_jurusan' => $jurusan->id_jurusan,
                            'id_jenis_kelas' => $jenisKelas->id_jenis_kelas,
                            'nama_kelas' => $jenisKelas->nama_jenis_kelas . ' ' . $jurusan->nama_jurusan . ' ' . $i,
                            'wali_kelas' => $waliKelas->id_guru,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                        
                        $counter++;
                        $guruIndex++;
                    }
                }
            }
        }

        $this->command->info("✅ {$counter} Kelas berhasil dibuat!");
    }
}