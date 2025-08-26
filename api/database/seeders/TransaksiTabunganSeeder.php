<?php

namespace Database\Seeders;

use App\Models\BukuTabungan;
use App\Models\Guru;
use App\Models\TransaksiTabungan;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class TransaksiTabunganSeeder extends Seeder
{
    public function run()
    {
        // Disable foreign key checks
        \DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        
        // Clear existing data
        TransaksiTabungan::truncate();
        
        // Re-enable foreign key checks
        \DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // Get all tabungan accounts
        $bukuTabungans = BukuTabungan::all();
        $gurus = Guru::all();
        $transactions = [];

        foreach ($bukuTabungans as $tabungan) {
            // Get random teacher from the same school
            $guru = $gurus->where('id_sekolah', $tabungan->siswa->id_sekolah)->random();
            
            // Generate 2-5 transactions per account
            $numTransactions = rand(2, 5);
            $currentDate = Carbon::now()->subMonths(3);
            
            for ($i = 0; $i < $numTransactions; $i++) {
                $jenis = rand(0, 1) ? 'setor' : 'tarik';
                $jumlah = $jenis === 'setor' ? rand(10, 50) * 1000 : rand(5, 20) * 1000;
                
                $transactions[] = [
                    'id_buku_tabungan' => $tabungan->id_buku_tabungan,
                    'id_guru' => $guru->id_guru,
                    'tanggal_transaksi' => $currentDate->copy()->addDays(rand(1, 20)),
                    'jenis_transaksi' => $jenis,
                    'jumlah' => $jumlah,
                ];
                
                // Update the saldo in the buku tabungan
                $tabungan->saldo += $jenis === 'setor' ? $jumlah : -$jumlah;
            }
            
            $tabungan->save();
        }

        // Insert all transactions
        foreach (array_chunk($transactions, 100) as $chunk) {
            TransaksiTabungan::insert($chunk);
        }

        $this->command->info('✅ Transaksi Tabungan berhasil dibuat!');
    }
}
