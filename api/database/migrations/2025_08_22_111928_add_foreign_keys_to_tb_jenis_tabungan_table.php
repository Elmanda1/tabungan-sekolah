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
        Schema::table('tb_jenis_tabungan', function (Blueprint $table) {
            $table->foreign(['id_sekolah'], 'tb_jenis_tabungan_ibfk_1')->references(['id_sekolah'])->on('tb_sekolah')->onUpdate('no action')->onDelete('no action');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tb_jenis_tabungan', function (Blueprint $table) {
            $table->dropForeign('tb_jenis_tabungan_ibfk_1');
        });
    }
};
