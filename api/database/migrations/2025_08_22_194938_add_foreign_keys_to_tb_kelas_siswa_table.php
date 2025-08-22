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
        Schema::table('tb_kelas_siswa', function (Blueprint $table) {
            $table->foreign(['id_kelas'], 'tb_kelas_siswa_ibfk_1')->references(['id_kelas'])->on('tb_kelas')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['id_siswa'], 'tb_kelas_siswa_ibfk_2')->references(['id_siswa'])->on('tb_siswa')->onUpdate('no action')->onDelete('no action');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tb_kelas_siswa', function (Blueprint $table) {
            $table->dropForeign('tb_kelas_siswa_ibfk_1');
            $table->dropForeign('tb_kelas_siswa_ibfk_2');
        });
    }
};
