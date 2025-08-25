<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Galeri extends Model
{
    use HasFactory;

    protected $table = 'tb_galeri';
    protected $primaryKey = 'id_galeri';

    protected $fillable = [
        'id_sekolah',
        'judul',
        'deskripsi',
        'gambar'
    ];

    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function getGambarUrlAttribute()
    {
        if ($this->gambar) {
            return asset('photos/' . $this->gambar);
        }
        return null;
    }
}