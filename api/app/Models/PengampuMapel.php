<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PengampuMapel extends Model
{
    use HasFactory;

    protected $table = 'tb_pengampu_mapel';
    protected $primaryKey = 'id_guru';

    protected $fillable = [
        'id_guru',
        'id_mapel'
    ];

    public function guru()
    {
        return $this->belongsTo(Guru::class, 'id_guru', 'id_guru');
    }

    public function mapel()
    {
        return $this->belongsTo(Mapel::class, 'id_mapel', 'id_mapel');
    }
}