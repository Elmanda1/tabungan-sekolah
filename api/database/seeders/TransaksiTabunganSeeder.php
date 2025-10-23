<?php

namespace Database\Seeders;

use App\Models\BukuTabungan;
use App\Models\Guru;
use App\Models\TransaksiTabungan;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TransaksiTabunganSeeder extends Seeder
{
    public function run()
    {
        // Disable foreign key checks
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        
        // Clear existing data
        TransaksiTabungan::truncate();
        
        // Re-enable foreign key checks
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // Get all tabungan accounts
        $bukuTabungans = BukuTabungan::all();
        $gurus = Guru::all();
        $transactions = [];

        foreach ($bukuTabungans as $tabungan) {
            // Get random teacher from the same school
            $guru = $gurus->where('id_sekolah', $tabungan->siswa->id_sekolah)->random();
            
            // Generate exactly 10 transactions per account
            $currentDate = Carbon::now()->subMonths(3);
            $saldo = $tabungan->saldo; // Get current saldo
            
            for ($i = 1; $i <= 10; $i++) {
                // Ensure we don't allow withdrawals that would make balance negative
                $maxWithdrawal = $saldo - 10000; // Keep minimum 10,000 in account
                $jenis = ($i === 1 || $maxWithdrawal > 25000) ? (rand(0, 1) ? 'setor' : 'tarik') : 'setor';
                
                if ($jenis === 'setor') {
                    $jumlah = rand(10, 50) * 1000; // 10,000 - 500,000
                } else {
                    $maxWithdrawable = min($maxWithdrawal, 200000); // Max 200,000 withdrawal at once
                    $jumlah = rand(5, min(20, $maxWithdrawable / 1000)) * 1000; // 5,000 - 200,000
                }
                
                $transactions[] = [
                    'id_buku_tabungan' => $tabungan->id_buku_tabungan,
                    'id_guru' => $guru->id_guru,
                    'tanggal_transaksi' => $currentDate->copy()->addDays(rand(1, 15))->addHours(rand(0, 23))->addMinutes(rand(0, 59)),
                    'jenis_transaksi' => $jenis,
                    'jumlah' => $jenis === 'setor' ? $jumlah : -$jumlah,
                ];
                
                // Update the saldo
                $saldo += $jenis === 'setor' ? $jumlah : -$jumlah;
            }
            
            // Save the final calculated saldo to the BukuTabungan model
            $tabungan->saldo = $saldo;
            $tabungan->save();
        }

        // Insert all transactions
        foreach (array_chunk($transactions, 100) as $chunk) {
            TransaksiTabungan::insert($chunk);
        }

        $this->command->info('✅ Transaksi Tabungan berhasil dibuat!');
    }
}
