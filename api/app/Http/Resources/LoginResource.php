<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LoginResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id_siswa,
            'nisn' => $this->nisn,
            'nama' => $this->nama_siswa,
            'kelas' => $this->kelas->nama_kelas ?? null,
            'jenis_kelamin' => $this->jenis_kelamin,
            'alamat' => $this->alamat,
            'no_telp' => $this->no_telp,
            'foto' => $this->foto ? asset('storage/' . $this->foto) : null,
            'saldo' => $this->bukuTabungan->saldo ?? 0,
        ];
    }
}
