<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Siswa;
use App\Models\Sekolah;
use Faker\Factory as Faker;

class SiswaSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create('id_ID');
        $sekolahList = Sekolah::all();
        
        $counter = 0;
        $nispCounter = 1001; // Starting NISN
        
        foreach ($sekolahList as $sekolah) {
            // Setiap sekolah minimal 30 siswa (total 60 siswa untuk 2 sekolah)
            for ($i = 0; $i < 30; $i++) {
                $gender = $faker->randomElement(['male', 'female']);
                $firstName = $faker->firstName($gender);
                $lastName = $faker->lastName;
                $fullName = $firstName . ' ' . $lastName;
                
                Siswa::create([
                    'id_sekolah' => $sekolah->id_sekolah,
                    'nisn' => $nispCounter++,
                    'nama_siswa' => $fullName,
                    'email' => $this->generateEmail($firstName, $lastName),
                    'no_telp' => $faker->phoneNumber,
                    'alamat' => $faker->address,
                    'foto' => $faker->randomElement(['hero.jpg', 'icon.png', null]),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                
                $counter++;
            }
        }

        $this->command->info("✅ {$counter} Siswa berhasil dibuat!");
    }

    private function generateEmail($firstName, $lastName)
    {
        return strtolower($firstName . '.' . $lastName) . '@student.sch.id';
    }
}