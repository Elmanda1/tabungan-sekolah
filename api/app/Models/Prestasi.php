<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prestasi extends Model
{
    use HasFactory;

    protected $table = 'tb_prestasi';
    protected $primaryKey = 'id_prestasi';

    protected $fillable = [
        'id_sekolah',
        'id_siswa',
        'judul',
        'deskripsi',
        'tanggal'
    ];

    protected $dates = [
        'tanggal'
    ];

    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function siswa()
    {
        return $this->belongsTo(Siswa::class, 'id_siswa', 'id_siswa');
    }

    public function scopeBySekolah($query, $idSekolah)
    {
        return $query->where('id_sekolah', $idSekolah);
    }

    public function scopeRecent($query, $limit = 10)
    {
        return $query->orderBy('tanggal', 'desc')->limit($limit);
    }

    public function home()
    {
        $prestasis = Prestasi::recent(3)->get(); // 3 terbaru
        return view('home', compact('prestasis'));
    }

}