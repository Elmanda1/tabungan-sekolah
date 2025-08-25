<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Sekolah;

class SekolahSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $sekolahData = [
            [
                'nama_sekolah' => 'SMA Negeri 100 Jakarta',
                'alamat' => 'Jl. Ir. H. Djuanda No. 161, Bogor Tengah, Kota Bogor, Jawa Barat 16121',
                'no_telp' => '0251-8323537',
                'email' => 'info@sman100jakarta.sch.id',
                'website' => 'https://www.sman100jakarta.sch.id'
            ],
            [
                'nama_sekolah' => 'SMA Negeri 3 Bogor',
                'alamat' => 'Jl. Pangrango No. 82, Panaragan, Bogor Tengah, Kota Bogor, Jawa Barat 16143',
                'no_telp' => '0251-8354662',
                'email' => 'info@sman3bogor.sch.id',
                'website' => 'https://www.sman3bogor.sch.id'
            ]
        ];

        foreach ($sekolahData as $data) {
            Sekolah::create($data);
        }

        $this->command->info('✅ 2 Sekolah berhasil dibuat!');
    }
}