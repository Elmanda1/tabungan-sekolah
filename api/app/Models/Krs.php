<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Krs extends Model
{
    use HasFactory;

    protected $table = 'tb_krs';
    protected $primaryKey = 'id_krs';

    protected $fillable = [
        'id_siswa',
        'id_mapel',
        'tahun_ajaran',
        'semester'
    ];

    public function siswa()
    {
        return $this->belongsTo(Siswa::class, 'id_siswa', 'id_siswa');
    }

    public function mapel()
    {
        return $this->belongsTo(Mapel::class, 'id_mapel', 'id_mapel');
    }

    public function scopeByTahunAjaran($query, $tahun)
    {
        return $query->where('tahun_ajaran', $tahun);
    }

    public function scopeBySemester($query, $semester)
    {
        return $query->where('semester', $semester);
    }
}