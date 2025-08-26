<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Siswa extends Model
{
    use HasFactory;

    protected $table = 'tb_siswa';
    protected $primaryKey = 'id_siswa';

    protected $fillable = [
        'id_sekolah',
        'nisn',
        'nama_siswa',
        'email',
        'no_telp',
        'alamat',
        'foto'
    ];

    // Relationships
    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function akun()
    {
        return $this->hasOne(Akun::class, 'id_siswa', 'id_siswa');
    }

    public function kelasSiswa()
    {
        return $this->hasMany(KelasSiswa::class, 'id_siswa', 'id_siswa');
    }

    public function kelas()
    {
        return $this->belongsToMany(Kelas::class, 'tb_kelas_siswa', 'id_siswa', 'id_kelas')
            ->withPivot('id_kelas', 'id_siswa')
            ->using(KelasSiswa::class);
    }

    public function prestasi()
    {
        return $this->hasMany(Prestasi::class, 'id_siswa', 'id_siswa');
    }

    public function krs()
    {
        return $this->hasMany(Krs::class, 'id_siswa', 'id_siswa');
    }

    // Scopes
    public function scopeBySekolah($query, $idSekolah)
    {
        return $query->where('id_sekolah', $idSekolah);
    }

    public function scopeWithPrestasi($query)
    {
        return $query->with('prestasi');
    }

    public function scopeByKelas($query, $idKelas)
    {
        return $query->whereHas('kelas', function($q) use ($idKelas) {
            $q->where('id_kelas', $idKelas);
        });
    }

    // Accessors
    public function getFotoUrlAttribute()
    {
        if ($this->foto) {
            return asset('photos/' . $this->foto);
        }
        return asset('photos/default-siswa.png');
    }

    public function getKelasTerakhirAttribute()
    {
        return $this->kelas()->first();
    }
}