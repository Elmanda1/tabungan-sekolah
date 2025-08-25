<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Guru;
use App\Models\Sekolah;
use Faker\Factory as Faker;
use Illuminate\Support\Facades\DB;

class GuruSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create('id_ID');
        
        $sekolahList = Sekolah::all();
        
        if ($sekolahList->count() == 0) {
            $this->command->error("❌ Tidak ada data sekolah. Jalankan seeder SekolahSeeder terlebih dahulu.");
            return;
        }
        
        $counter = 0;
        
        // Clear existing data
        DB::table('tb_guru')->delete();
        
        foreach ($sekolahList as $sekolah) {
            // Setiap sekolah minimal 12 guru
            for ($i = 0; $i < 12; $i++) {
                $counter++;
                
                // Generate nama random dengan faker
                $isPria = $faker->boolean(50);
                $gelar = $faker->randomElement(['Drs.', 'Dr.', 'Dra.', 'Prof.']);
                $pendidikan = $faker->randomElement(['M.Pd', 'S.Pd', 'M.Si', 'S.Si']);
                $firstName = $isPria ? $faker->firstNameMale : $faker->firstNameFemale;
                $lastName = $faker->lastName;
                $namaGuru = $gelar . ' ' . $firstName . ' ' . $lastName . ', ' . $pendidikan;
                
                // Generate NIP (18 digits)
                $nip = $faker->unique()->numerify('####################');
                
                try {
                    Guru::create([
                        'id_sekolah' => $sekolah->id_sekolah,
                        'nama_guru' => $namaGuru,
                        'nip' => $nip,
                        'email' => 'guru' . $counter . '@school.edu',
                        'no_telp' => $faker->phoneNumber,
                        'alamat' => $faker->address,
                        'foto' => $faker->randomElement(['hero.jpg', 'icon.png', null]),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                } catch (\Exception $e) {
                    $this->command->error("❌ Error creating guru {$counter}: " . $e->getMessage());
                    continue;
                }
            }
        }

        $this->command->info("✅ {$counter} Guru berhasil dibuat!");
    }
}