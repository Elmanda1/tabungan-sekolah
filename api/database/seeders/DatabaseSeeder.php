<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run()
    {
        // Clear existing records
        $this->command->info('Clearing existing records...');
        
        $this->call([
            SekolahSeeder::class,
            JenisKelasSeeder::class,
            JurusanSeeder::class,
            GuruSeeder::class,
            SiswaSeeder::class,
            MapelSeeder::class,
            KelasSeeder::class,
            ArtikelSeeder::class,
            PrestasiSeeder::class,
            GaleriSeeder::class,
            AkunSeeder::class,
        ]);

        $this->command->info('✨ All data has been seeded successfully!');
    }
}