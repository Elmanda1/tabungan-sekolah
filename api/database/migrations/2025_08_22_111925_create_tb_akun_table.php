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
        Schema::create('tb_akun', function (Blueprint $table) {
            $table->integer('id_akun', true);
            $table->string('username', 100)->unique('username');
            $table->string('password');
            $table->enum('role', ['admin','guru', 'siswa']);
            $table->integer('id_guru')->nullable()->index('idx_akun_id_guru');
            $table->integer('id_siswa')->nullable()->index('idx_akun_id_siswa');
            $table->timestamp('created_at')->nullable()->useCurrent();
            $table->timestamp('updated_at')->useCurrentOnUpdate()->nullable()->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_akun');
    }
};
