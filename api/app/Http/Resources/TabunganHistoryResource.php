<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TabunganHistoryResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'tanggal' => $this->tanggal,
            'jumlah' => (float) $this->nominal,
            'keterangan' => $this->keterangan
        ];
    }
}
