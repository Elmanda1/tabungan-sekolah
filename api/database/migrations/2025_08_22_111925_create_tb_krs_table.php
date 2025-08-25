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
        Schema::create('tb_krs', function (Blueprint $table) {
            $table->integer('id_krs', true);
            $table->integer('id_siswa')->index('id_siswa');
            $table->integer('id_mapel')->index('id_mapel');
            $table->string('tahun_ajaran', 50)->nullable();
            $table->string('semester', 50)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_krs');
    }
};
