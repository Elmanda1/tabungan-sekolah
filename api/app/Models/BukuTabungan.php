<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class BukuTabungan extends Model
{
    protected $table = 'tb_buku_tabungan';
    protected $primaryKey = 'id_buku_tabungan';
    public $timestamps = false;

    protected $fillable = [
        'id_siswa',
        'id_jenis_tabungan',
        'saldo',
    ];

    protected $casts = [
        'saldo' => 'float',
    ];

    public function siswa(): BelongsTo
    {
        return $this->belongsTo(Siswa::class, 'id_siswa', 'id_siswa');
    }

    public function transaksi(): HasMany
    {
        return $this->hasMany(TransaksiTabungan::class, 'id_buku_tabungan', 'id_buku_tabungan');
    }

    public function jenisTabungan(): BelongsTo
    {
        return $this->belongsTo(JenisTabungan::class, 'id_jenis_tabungan', 'id_jenis_tabungan');
    }
}
