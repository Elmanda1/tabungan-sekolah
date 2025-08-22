<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\LoginResource;
use App\Models\Siswa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'nisn' => 'required|string',
            'password' => 'required|string',
            'device_name' => 'string|nullable',
        ]);
        
        $deviceName = $request->device_name ?? 'mobile_app';

        $siswa = Siswa::where('nisn', $request->nisn)->first();

        if (!$siswa || $siswa->no_telp !== $request->password) {
            throw ValidationException::withMessages([
                'nisn' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $siswa->createToken($deviceName)->plainTextToken;

        return response()->json([
            'status' => 'success',
            'access_token' => $token,
            'token_type' => 'Bearer'
        ]);
    }

    public function me(Request $request)
    {
        return new LoginResource($request->user());
    }

    public function profile(Request $request)
    {
        try {
            $siswa = $request->user();
            
            // Make sure we have the latest data
            $siswa->load(['sekolah', 'kelas']);
            
            return response()->json([
                'nama_sekolah' => $siswa->sekolah ? $siswa->sekolah->nama_sekolah : 'Nama Sekolah',
                'nama_siswa' => $siswa->nama_siswa,
                'kelas' => $siswa->kelas ? $siswa->kelas->nama_kelas : 'Kelas tidak ditemukan'
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
