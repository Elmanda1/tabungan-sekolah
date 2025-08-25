<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Jurusan extends Model
{
    use HasFactory;

    protected $table = 'tb_jurusan';
    protected $primaryKey = 'id_jurusan';

    protected $fillable = [
        'id_sekolah',
        'nama_jurusan'
    ];

    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function kelas()
    {
        return $this->hasMany(Kelas::class, 'id_jurusan', 'id_jurusan');
    }

    public function scopeBySekolah($query, $idSekolah)
    {
        return $query->where('id_sekolah', $idSekolah);
    }
}