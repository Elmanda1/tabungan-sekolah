<?php

use App\Http\Controllers\Api\AkunController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\TabunganController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Public routes
Route::post('/auth/login', [AuthController::class, 'login']);

// Test route to verify API is working
Route::get('/test', function () {
    return response()->json(['message' => 'API is working!']);
});

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // Authentication
    Route::get('/akun', [AkunController::class, 'profile']);
    Route::post('/gantipw', [AkunController::class, 'changePassword']);
    Route::post('/auth/logout', [AuthController::class, 'logout']);
    Route::get('/profile', [AuthController::class, 'profile']);
    
    // Tabungan
    Route::prefix('tabungan')->group(function () {
        Route::get('/history', [TabunganController::class, 'history']);
        Route::get('/income-expenses', [TabunganController::class, 'incomeExpenses']);
        Route::get('/saldo', [TabunganController::class, 'saldo']);
    });
});
