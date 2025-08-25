<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tb_transaksi_tabungan', function (Blueprint $table) {
            $table->integer('id_transaksi', true);
            $table->integer('id_buku_tabungan')->index('id_buku_tabungan');
            $table->integer('id_guru')->index('id_guru');
            $table->date('tanggal_transaksi');
            $table->enum('jenis_transaksi', ['setor', 'tarik']);
            $table->decimal('jumlah', 15);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_transaksi_tabungan');
    }
};
