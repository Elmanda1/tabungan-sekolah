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
        Schema::table('tb_akun', function (Blueprint $table) {
            $table->foreign(['id_guru'], 'tb_akun_ibfk_1')->references(['id_guru'])->on('tb_guru')->onUpdate('no action')->onDelete('cascade');
            $table->foreign(['id_siswa'], 'tb_akun_ibfk_2')->references(['id_siswa'])->on('tb_siswa')->onUpdate('no action')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tb_akun', function (Blueprint $table) {
            $table->dropForeign('tb_akun_ibfk_1');
            $table->dropForeign('tb_akun_ibfk_2');
        });
    }
};
