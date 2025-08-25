<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\LoginResource;
use App\Models\Siswa;
use App\Models\Akun;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
            'device_name' => 'string|nullable',
        ]);
        
        $deviceName = $request->device_name ?? 'mobile_app';

        // Find account by username
        $akun = Akun::where('username', $request->username)->first();

        // Check if account exists and password is correct
        if (!$akun || !Hash::check($request->password, $akun->password)) {
            throw ValidationException::withMessages([
                'username' => ['The provided credentials are incorrect.'],
            ]);
        }

        // Get the user based on role
        $user = null;
        if ($akun->role === 'siswa' && $akun->id_siswa) {
            $user = Siswa::find($akun->id_siswa);
        } elseif (in_array($akun->role, ['admin', 'guru']) && $akun->id_guru) {
            // If you have a Guru model, you can load it here
            // $user = Guru::find($akun->id_guru);
            // For now, we'll just use the account
            $user = $akun;
        }

        if (!$user) {
            throw ValidationException::withMessages([
                'username' => ['User account not properly configured.'],
            ]);
        }

        // Create token for the user
        $token = $akun->createToken($deviceName)->plainTextToken;

        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'role' => $akun->role,
            'id_siswa' => $akun->id_siswa
        ]);
    }

    public function me(Request $request)
    {
        return new LoginResource($request->user());
    }

    public function profile(Request $request)
    {
        try {
            $user = $request->user();
            
            // If user is a student
            if (isset($user->id_siswa)) {
                $siswa = Siswa::with(['sekolah', 'kelas'])->find($user->id_siswa);
                
                $kelasNama = 'Kelas tidak ditemukan';
                if ($siswa->kelas && $siswa->kelas->isNotEmpty()) {
                    $kelasNama = $siswa->kelas->first()->nama_kelas ?? 'Kelas tidak ditemukan';
                }
                
                return response()->json([
                    'role' => 'siswa',
                    'sekolah' => $siswa->sekolah ? $siswa->sekolah->nama_sekolah : 'Nama Sekolah',
                    'nama' => $siswa->nama_siswa,
                    'kelas' => $kelasNama
                ]);
            }
            
            // For admin/teacher, adjust based on your Guru model if needed
            return response()->json([
                'role' => $user->role,
                'username' => $user->username,
                'message' => 'Admin/Guru profile'
            ]);
            
        } catch (\Exception $e) {
            \Log::error('Profile error: ' . $e->getMessage());
            return response()->json([
                'message' => 'Error fetching profile',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        
        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }
}
