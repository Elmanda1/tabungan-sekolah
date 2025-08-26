<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Siswa;
use App\Models\Kelas;
use Illuminate\Support\Facades\DB;

class KelasSiswaSeeder extends Seeder
{
    public function run(): void
    {
        // Get all active classes
        $kelasList = Kelas::all();
        
        if ($kelasList->isEmpty()) {
            $this->command->warn('No classes found. Please run KelasSeeder first.');
            return;
        }
        
        // Get all students
        $siswaList = Siswa::all();
        
        if ($siswaList->isEmpty()) {
            $this->command->warn('No students found. Please run SiswaSeeder first.');
            return;
        }
        
        $this->command->info('Seeding class assignments for students...');
        
        // Clear existing data
        DB::table('tb_kelas_siswa')->truncate();
        
        // Assign students to classes
        $kelasIndex = 0;
        $studentsPerClass = [20, 25, 30]; // Variable class sizes for realism
        $kelasCount = $kelasList->count();
        $studentsAssigned = 0;
        
        foreach ($siswaList as $index => $siswa) {
            // Get current class (cycle through all classes)
            $kelas = $kelasList[$kelasIndex];
            
            // Assign student to class (only id_kelas and id_siswa as per schema)
            DB::table('tb_kelas_siswa')->insert([
                'id_kelas' => $kelas->id_kelas,
                'id_siswa' => $siswa->id_siswa
            ]);
            
            $studentsAssigned++;
            
            // Move to next class if we've assigned enough students to current class
            $currentClassSize = $studentsPerClass[array_rand($studentsPerClass)];
            if (($index + 1) % $currentClassSize === 0) {
                $kelasIndex = ($kelasIndex + 1) % $kelasCount;
                
                // Show progress
                if ($kelasIndex % 5 === 0) {
                    $this->command->info("Assigned {$studentsAssigned} students to classes...");
                }
            }
        }
        
        $this->command->info("✅ Successfully assigned {$studentsAssigned} students to classes.");
    }
}
