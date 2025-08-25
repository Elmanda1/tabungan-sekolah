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
        Schema::create('tb_siswa', function (Blueprint $table) {
            $table->integer('id_siswa', true);
            $table->integer('id_sekolah')->index('id_sekolah');
            $table->string('nisn', 50)->unique('nisn');
            $table->string('nama_siswa');
            $table->string('email')->nullable()->unique('email');
            $table->string('no_telp', 50)->nullable();
            $table->string('alamat')->nullable();
            $table->string('foto')->nullable();
            $table->timestamps(); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_siswa');
    }
};
