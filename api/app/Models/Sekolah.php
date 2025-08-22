<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Sekolah extends Model
{
    protected $table = 'tb_sekolah';
    protected $primaryKey = 'id_sekolah';
    public $timestamps = false;

    protected $fillable = [
        'nama_sekolah',
        'alamat',
        'no_telp',
        'email',
        'website'
    ];

    public function siswa(): HasMany
    {
        return $this->hasMany(Siswa::class, 'id_sekolah', 'id_sekolah');
    }
}
