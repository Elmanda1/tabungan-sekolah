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
        Schema::table('tb_pengampu_mapel', function (Blueprint $table) {
            $table->foreign(['id_guru'], 'tb_pengampu_mapel_ibfk_1')->references(['id_guru'])->on('tb_guru')->onUpdate('no action')->onDelete('no action');
            $table->foreign(['id_mapel'], 'tb_pengampu_mapel_ibfk_2')->references(['id_mapel'])->on('tb_mapel')->onUpdate('no action')->onDelete('no action');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tb_pengampu_mapel', function (Blueprint $table) {
            $table->dropForeign('tb_pengampu_mapel_ibfk_1');
            $table->dropForeign('tb_pengampu_mapel_ibfk_2');
        });
    }
};
