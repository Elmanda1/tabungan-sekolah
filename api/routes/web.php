<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return response()->json([
        'message' => 'Tabungan Sekolah API Server',
        'status' => 'running',
        'laravel_version' => app()->version(),
        'php_version' => phpversion(),
    ]);
});