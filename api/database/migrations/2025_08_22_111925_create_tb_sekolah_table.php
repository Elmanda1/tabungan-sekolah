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
            $table->integer('id_sekolah', true);
            $table->string('nama_sekolah');
            $table->string('alamat')->nullable();
            $table->string('no_telp', 50)->nullable();
            $table->string('email')->nullable();
            $table->string('website')->nullable();
            $table->timestamps(); 
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
