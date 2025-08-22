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
        Schema::create('tb_buku_tabungan', function (Blueprint $table) {
            $table->integer('id_buku_tabungan', true);
            $table->integer('id_siswa')->index('id_siswa');
            $table->integer('id_jenis_tabungan')->index('id_jenis_tabungan');
            $table->decimal('saldo', 15)->nullable()->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_buku_tabungan');
    }
};
