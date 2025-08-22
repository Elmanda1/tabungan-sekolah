<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Sekolah;

class SekolahSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Sekolah::create([
            'id_sekolah' => 1,
            'nama_sekolah' => 'SMA Negeri 1 Jakarta',
            'alamat' => 'Jl. Budi Utomo No.7, Jakarta Pusat',
            'no_telp' => '021-3841000',
            'email' => 'info@sman1jkt.sch.id',
            'website' => 'www.sman1jkt.sch.id'
        ]);
    }
}
