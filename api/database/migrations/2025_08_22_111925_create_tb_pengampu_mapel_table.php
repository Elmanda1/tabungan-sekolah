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
        Schema::create('tb_pengampu_mapel', function (Blueprint $table) {
            $table->integer('id_guru');
            $table->integer('id_mapel')->index('id_mapel');

            $table->primary(['id_guru', 'id_mapel']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_pengampu_mapel');
    }
};
