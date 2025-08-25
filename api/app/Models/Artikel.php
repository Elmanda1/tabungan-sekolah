<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Artikel extends Model
{
    use HasFactory;

    protected $table = 'tb_artikel';
    protected $primaryKey = 'id_artikel';

    protected $fillable = [
        'id_sekolah',
        'judul',
        'isi',
        'tanggal',
        'gambar'
    ];

    protected $dates = [
        'tanggal'
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

    public function scopeBySekolah($query, $idSekolah)
    {
        return $query->where('id_sekolah', $idSekolah);
    }

    public function scopePublished($query)
    {
        return $query->whereNotNull('tanggal')
                    ->where('tanggal', '<=', now());
    }

    public function scopeRecent($query, $limit = 10)
    {
        return $query->orderBy('tanggal', 'desc')->limit($limit);
    }
}
