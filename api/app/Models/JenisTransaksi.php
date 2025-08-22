<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class JenisTransaksi extends Model
{
    protected $table = 'tb_jenis_transaksi';
    protected $primaryKey = 'id_jenis_transaksi';
    public $timestamps = false;

    protected $fillable = [
        'nama_jenis_transaksi',
        'jenis', // 'kredit' or 'debit'
    ];

    public function transaksi(): HasMany
    {
        return $this->hasMany(TransaksiTabungan::class, 'id_jenis_transaksi', 'id_jenis_transaksi');
    }
}
