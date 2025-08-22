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
        Schema::table('tb_kelas', function (Blueprint $table) {
            $table->foreign(['id_sekolah'], 'tb_kelas_ibfk_1')->references(['id_sekolah'])->on('tb_sekolah')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['id_jurusan'], 'tb_kelas_ibfk_2')->references(['id_jurusan'])->on('tb_jurusan')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['id_jenis_kelas'], 'tb_kelas_ibfk_3')->references(['id_jenis_kelas'])->on('tb_jenis_kelas')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['wali_kelas'], 'tb_kelas_ibfk_4')->references(['id_guru'])->on('tb_guru')->onUpdate('no action')->onDelete('no action');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tb_kelas', function (Blueprint $table) {
            $table->dropForeign('tb_kelas_ibfk_1');
            $table->dropForeign('tb_kelas_ibfk_2');
            $table->dropForeign('tb_kelas_ibfk_3');
            $table->dropForeign('tb_kelas_ibfk_4');
        });
    }
};
