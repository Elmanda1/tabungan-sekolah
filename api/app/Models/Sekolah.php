<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sekolah extends Model
{
    use HasFactory;

    protected $table = 'tb_sekolah';
    protected $primaryKey = 'id_sekolah';

    protected $fillable = [
        'nama_sekolah',
        'alamat',
        'no_telp',
        'email',
        'website'
    ];

    // Relationships
    public function jurusan()
    {
        return $this->hasMany(Jurusan::class, 'id_sekolah', 'id_sekolah');
    }

    public function guru()
    {
        return $this->hasMany(Guru::class, 'id_sekolah', 'id_sekolah');
    }

    public function siswa()
    {
        return $this->hasMany(Siswa::class, 'id_sekolah', 'id_sekolah');
    }

    public function kelas()
    {
        return $this->hasMany(Kelas::class, 'id_sekolah', 'id_sekolah');
    }

    public function artikel()
    {
        return $this->hasMany(Artikel::class, 'id_sekolah', 'id_sekolah');
    }

    public function prestasi()
    {
        return $this->hasMany(Prestasi::class, 'id_sekolah', 'id_sekolah');
    }

    public function mapel()
    {
        return $this->hasMany(Mapel::class, 'id_sekolah', 'id_sekolah');
    }

    public function galeri()
    {
        return $this->hasMany(Galeri::class, 'id_sekolah', 'id_sekolah');
    }

    // Scopes
    public function scopeWithCounts($query)
    {
        return $query->withCount([
            'guru',
            'siswa', 
            'kelas',
            'jurusan',
            'artikel',
            'prestasi'
        ]);
    }
}