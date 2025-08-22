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
        Schema::create('tb_sekolah', function (Blueprint $table) {
            $table->integer('id_sekolah')->primary();
            $table->string('nama_sekolah', 255);
            $table->string('alamat', 255)->nullable();
            $table->string('no_telp', 50)->nullable();
            $table->string('email', 255)->nullable();
            $table->string('website', 255)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_sekolah');
    }
};
