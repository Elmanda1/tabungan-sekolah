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
        Schema::create('tb_jenis_tabungan', function (Blueprint $table) {
            $table->integer('id_jenis_tabungan', true);
            $table->integer('id_sekolah')->index('id_sekolah');
            $table->string('nama_jenis_tabungan');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_jenis_tabungan');
    }
};
