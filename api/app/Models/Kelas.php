<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kelas extends Model
{
    use HasFactory;

    protected $table = 'tb_kelas';
    protected $primaryKey = 'id_kelas';

    protected $fillable = [
        'id_sekolah',
        'id_jurusan',
        'id_jenis_kelas',
        'nama_kelas',
        'wali_kelas'
    ];

    // Relationships
    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function jurusan()
    {
        return $this->belongsTo(Jurusan::class, 'id_jurusan', 'id_jurusan');
    }

    public function jenisKelas()
    {
        return $this->belongsTo(JenisKelas::class, 'id_jenis_kelas', 'id_jenis_kelas');
    }

    public function waliKelas()
    {
        return $this->belongsTo(Guru::class, 'wali_kelas', 'id_guru');
    }

    public function kelasSiswa()
    {
        return $this->hasMany(KelasSiswa::class, 'id_kelas', 'id_kelas');
    }

    public function siswa()
    {
        return $this->belongsToMany(Siswa::class, 'tb_kelas_siswa', 'id_kelas', 'id_siswa')
                    ->withPivot('tahun_ajaran', 'semester');
    }

    // Scopes
    public function scopeBySekolah($query, $idSekolah)
    {
        return $query->where('id_sekolah', $idSekolah);
    }

    public function scopeByJurusan($query, $idJurusan)
    {
        return $query->where('id_jurusan', $idJurusan);
    }

    public function scopeWithSiswaCount($query)
    {
        return $query->withCount('siswa');
    }

    // Accessors
    public function getNamaLengkapAttribute()
    {
        $jenisKelas = $this->jenisKelas ? $this->jenisKelas->nama_jenis_kelas : '';
        $jurusan = $this->jurusan ? $this->jurusan->nama_jurusan : '';
        
        return "{$jenisKelas} {$jurusan} - {$this->nama_kelas}";
    }

    public function getJumlahSiswaAttribute()
    {
        return $this->siswa()->count();
    }
}