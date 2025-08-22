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
        Schema::create('tb_artikel', function (Blueprint $table) {
            $table->integer('id_artikel', true);
            $table->integer('id_sekolah')->index('id_sekolah');
            $table->string('judul');
            $table->text('isi')->nullable();
            $table->date('tanggal')->nullable();
            $table->string('gambar')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_artikel');
    }
};
