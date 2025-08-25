<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisKelas extends Model
{
    use HasFactory;

    protected $table = 'tb_jenis_kelas';
    protected $primaryKey = 'id_jenis_kelas';

    protected $fillable = [
        'nama_jenis_kelas'
    ];

    public function kelas()
    {
        return $this->hasMany(Kelas::class, 'id_jenis_kelas', 'id_jenis_kelas');
    }
}