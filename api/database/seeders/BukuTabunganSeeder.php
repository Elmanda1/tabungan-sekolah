<?php

namespace Database\Seeders;

use App\Models\BukuTabungan;
use App\Models\Siswa;
use Illuminate\Database\Seeder;

class BukuTabunganSeeder extends Seeder
{
    public function run()
    {
        // Disable foreign key checks
        \DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        
        // Clear existing data
        BukuTabungan::truncate();
        
        // Re-enable foreign key checks
        \DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // Get all students
        $siswas = Siswa::all();
        
        // For each student, create a tabungan account for each jenis tabungan
        foreach ($siswas as $siswa) {
            // Create Tabungan Wajib (ID 1 or 3 depending on school)
            $jenisWajib = $siswa->id_sekolah == 1 ? 1 : 3;
            BukuTabungan::create([
                'id_siswa' => $siswa->id_siswa,
                'id_jenis_tabungan' => $jenisWajib,
                'saldo' => 0
            ]);

            // Create Tabungan Sukarela (ID 2 or 4 depending on school)
            $jenisSukarela = $siswa->id_sekolah == 1 ? 2 : 4;
            BukuTabungan::create([
                'id_siswa' => $siswa->id_siswa,
                'id_jenis_tabungan' => $jenisSukarela,
                'saldo' => 0
            ]);
        }

        $this->command->info('✅ Buku Tabungan berhasil dibuat!');
    }
}
