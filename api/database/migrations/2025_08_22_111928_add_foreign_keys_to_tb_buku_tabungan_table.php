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
        Schema::table('tb_buku_tabungan', function (Blueprint $table) {
            $table->foreign(['id_siswa'], 'tb_buku_tabungan_ibfk_1')->references(['id_siswa'])->on('tb_siswa')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['id_jenis_tabungan'], 'tb_buku_tabungan_ibfk_2')->references(['id_jenis_tabungan'])->on('tb_jenis_tabungan')->onUpdate('no action')->onDelete('no action');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tb_buku_tabungan', function (Blueprint $table) {
            $table->dropForeign('tb_buku_tabungan_ibfk_1');
            $table->dropForeign('tb_buku_tabungan_ibfk_2');
        });
    }
};
