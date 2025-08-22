<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;

class Siswa extends Authenticatable
{
    use HasApiTokens;
    
    protected $table = 'tb_siswa';
    protected $primaryKey = 'id_siswa';
    public $timestamps = false;

    protected $fillable = [
        'nisn',
        'password',
        'nama_siswa',
        'jenis_kelamin',
        'alamat',
        'no_telp',
        'foto',
        'id_kelas',
        'id_sekolah',
    ];

    protected $hidden = [
        'password',
    ];

    public function kelas(): BelongsTo
    {
        return $this->belongsTo(Kelas::class, 'id_kelas', 'id_kelas');
    }

    public function sekolah(): BelongsTo
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function bukuTabungan(): HasOne
    {
        return $this->hasOne(BukuTabungan::class, 'id_siswa', 'id_siswa');
    }
}
