<?php

namespace Database\Seeders;

use App\Models\JenisTabungan;
use Illuminate\Database\Seeder;

class JenisTabunganSeeder extends Seeder
{
    public function run()
    {
        $jenisTabungan = [
            ['id_sekolah' => 1, 'nama_jenis_tabungan' => 'Tabungan Wajib'],
            ['id_sekolah' => 1, 'nama_jenis_tabungan' => 'Tabungan Sukarela'],
            ['id_sekolah' => 2, 'nama_jenis_tabungan' => 'Tabungan Wajib'],
            ['id_sekolah' => 2, 'nama_jenis_tabungan' => 'Tabungan Sukarela'],
        ];

        foreach ($jenisTabungan as $jenis) {
            JenisTabungan::create($jenis);
        }

        $this->command->info('✅ Jenis Tabungan berhasil dibuat!');
    }
}
