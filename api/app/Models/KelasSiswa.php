<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;

class KelasSiswa extends Pivot
{
    protected $table = 'tb_kelas_siswa';
    protected $primaryKey = ['id_kelas', 'id_siswa'];
    public $incrementing = false;
    public $timestamps = false;

    protected $fillable = [
        'id_kelas',
        'id_siswa'
    ];

    public function kelas()
    {
        return $this->belongsTo(Kelas::class, 'id_kelas', 'id_kelas');
    }
}
