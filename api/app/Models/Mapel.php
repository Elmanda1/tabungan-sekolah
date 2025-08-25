<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mapel extends Model
{
    use HasFactory;

    protected $table = 'tb_mapel';
    protected $primaryKey = 'id_mapel';

    protected $fillable = [
        'id_sekolah',
        'nama_mapel',
        'judul',
        'deskripsi',
        'gambar'
    ];

    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function pengampuMapel()
    {
        return $this->hasMany(PengampuMapel::class, 'id_mapel', 'id_mapel');
    }

    public function guru()
    {
        return $this->belongsToMany(Guru::class, 'tb_pengampu_mapel', 'id_mapel', 'id_guru');
    }

    public function getGambarUrlAttribute()
    {
        if ($this->gambar) {
            return asset('photos/' . $this->gambar);
        }
        return asset('photos/default-mapel.png');
    }
}