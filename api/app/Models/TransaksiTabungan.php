<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TransaksiTabungan extends Model
{
    protected $table = 'tb_transaksi_tabungan';
    protected $primaryKey = 'id_transaksi';
    public $timestamps = false;

    protected $fillable = [
        'id_buku_tabungan',
        'id_jenis_transaksi',
        'nominal',
        'keterangan',
        'tanggal',
    ];

    protected $casts = [
        'nominal' => 'float',
        'tanggal' => 'date',
    ];

    public function bukuTabungan(): BelongsTo
    {
        return $this->belongsTo(BukuTabungan::class, 'id_buku_tabungan', 'id_buku_tabungan');
    }

    public function jenisTransaksi(): BelongsTo
    {
        return $this->belongsTo(JenisTransaksi::class, 'id_jenis_transaksi', 'id_jenis_transaksi');
    }
}
