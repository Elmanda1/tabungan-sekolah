<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

use App\Models\Siswa;
use App\Models\Akun;

class AkunController extends Controller
{
    public function profile()
    {
        $user = Auth::user();

        if ($user->role === 'siswa' && $user->id_siswa) {
            $siswa = Siswa::with('kelasSiswa.kelas')->find($user->id_siswa);

            if ($siswa) {
                $kelasNama = 'Kelas tidak ditemukan';
                if ($siswa->kelasSiswa->isNotEmpty() && $siswa->kelasSiswa->first()->kelas) {
                    $kelasNama = $siswa->kelasSiswa->first()->kelas->nama_kelas;
                }

                return response()->json([
                    'nama_siswa' => $siswa->nama_siswa,
                    'kelas' => $kelasNama,
                    'role' => 'siswa',
                ]);
            }
        }

        return response()->json([
            'username' => $user->username,
            'role' => $user->role,
        ]);
    }

    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:8|confirmed',
        ]);

        $user = Auth::user();

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'Password lama tidak sesuai'], 400);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        return response()->json(['message' => 'Password berhasil diubah']);
    }
}
