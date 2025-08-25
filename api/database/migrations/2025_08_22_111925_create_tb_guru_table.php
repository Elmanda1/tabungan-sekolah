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
        Schema::create('tb_guru', function (Blueprint $table) {
            $table->integer('id_guru', true); // Auto increment primary key
            $table->integer('id_sekolah')->index('id_sekolah');
            $table->string('nama_guru');
            $table->string('nip', 20)->unique();
            $table->string('email')->nullable()->unique('email');
            $table->string('no_telp', 50)->nullable();
            $table->text('alamat')->nullable(); 
            $table->string('foto')->nullable();
            $table->timestamps(); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_guru');
    }
};