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
        Schema::create('tb_kelas', function (Blueprint $table) {
            $table->integer('id_kelas', true);
            $table->integer('id_sekolah')->index('id_sekolah');
            $table->integer('id_jurusan')->nullable()->index('id_jurusan');
            $table->integer('id_jenis_kelas')->nullable()->index('id_jenis_kelas');
            $table->string('nama_kelas');
            $table->integer('wali_kelas')->nullable()->index('wali_kelas');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_kelas');
    }
};
