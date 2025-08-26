<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisTabungan extends Model
{
    use HasFactory;

    protected $table = 'tb_jenis_tabungan';
    protected $primaryKey = 'id_jenis_tabungan';
    public $timestamps = false;

    protected $fillable = [
        'id_sekolah',
        'nama_jenis_tabungan'
    ];

    // Relationships
    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function bukuTabungan()
    {
        return $this->hasMany(BukuTabungan::class, 'id_jenis_tabungan', 'id_jenis_tabungan');
    }
}
