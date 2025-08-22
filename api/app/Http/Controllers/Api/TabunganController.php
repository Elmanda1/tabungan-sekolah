<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\TabunganHistoryResource;
use App\Models\TransaksiTabungan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TabunganController extends Controller
{
    public function history(Request $request)
    {
        $user = $request->user();
        
        $transactions = TransaksiTabungan::with(['jenisTransaksi'])
            ->where('id_siswa', $user->id_siswa)
            ->orderBy('tanggal', 'desc')
            ->orderBy('created_at', 'desc')
            ->get();

        return TabunganHistoryResource::collection($transactions);
    }

    public function saldo(Request $request)
    {
        $user = $request->user();
        
        $saldo = DB::table('tb_buku_tabungan')
            ->where('id_siswa', $user->id_siswa)
            ->value('saldo') ?? 0;

        return response()->json([
            'saldo' => (float) $saldo
        ]);
    }

    public function history3(Request $request)
    {
        $user = $request->user();
        
        $transactions = TransaksiTabungan::with(['jenisTransaksi'])
            ->where('id_siswa', $user->id_siswa)
            ->orderBy('tanggal', 'desc')
            ->orderBy('created_at', 'desc')
            ->take(3)
            ->get();

        return TabunganHistoryResource::collection($transactions);
    }

    public function incomeExpenses(Request $request)
    {
        $user = $request->user();
        
        $totals = TransaksiTabungan::select(
                DB::raw('SUM(CASE WHEN jumlah > 0 THEN jumlah ELSE 0 END) as total_income'),
                DB::raw('SUM(CASE WHEN jumlah < 0 THEN ABS(jumlah) ELSE 0 END) as total_expenses')
            )
            ->where('id_siswa', $user->id_siswa)
            ->first();

        return response()->json([
            'total_income' => (float) ($totals->total_income ?? 0),
            'total_expenses' => (float) ($totals->total_expenses ?? 0)
        ]);
    }
}
