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
        Schema::create('tb_kelas_siswa', function (Blueprint $table) {
            $table->integer('id_kelas');
            $table->integer('id_siswa')->index('id_siswa');

            $table->primary(['id_kelas', 'id_siswa']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_kelas_siswa');
    }
};
