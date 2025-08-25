<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Guru extends Model
{
    use HasFactory;

    protected $table = 'tb_guru';
    protected $primaryKey = 'id_guru';

    protected $fillable = [
        'id_sekolah',
        'nama_guru',
        'nip',
        'email',
        'no_telp',
        'alamat',
        'foto'
    ];

    protected $casts = [
        'id_guru' => 'integer',
        'id_sekolah' => 'integer',
    ];

    // Relationships
    public function sekolah()
    {
        return $this->belongsTo(Sekolah::class, 'id_sekolah', 'id_sekolah');
    }

    public function akun()
    {
        return $this->hasOne(Akun::class, 'id_guru', 'id_guru');
    }

    public function pengampuMapel()
    {
        return $this->hasMany(PengampuMapel::class, 'id_guru', 'id_guru');
    }

    public function mapel()
    {
        return $this->belongsToMany(Mapel::class, 'tb_pengampu_mapel', 'id_guru', 'id_mapel');
    }

    public function kelasWali()
    {
        return $this->hasMany(Kelas::class, 'wali_kelas', 'id_guru');
    }

    // Scopes
    public function scopeWithMapel($query)
    {
        return $query->with('mapel');
    }

    public function scopeBySekolah($query, $idSekolah)
    {
        return $query->where('id_sekolah', $idSekolah);
    }

    public function scopeWithSekolah($query)
    {
        return $query->with('sekolah');
    }

    // Accessors
    public function getFotoUrlAttribute()
    {
        if ($this->foto) {
            return asset('storage/photos/' . $this->foto);
        }
        return asset('storage/photos/default-guru.png');
    }

    public function getNamaLengkapAttribute()
    {
        return $this->nama_guru;
    }

    // Mutators
    public function setEmailAttribute($value)
    {
        $this->attributes['email'] = strtolower($value);
    }
}