<?php

use App\Http\Controllers\Api\TelasAPI;
use App\Http\Controllers\Api\VentasAPI;
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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::get('ventas',[VentasAPI::class, 'obtenerVentas']);
Route::get('ventas/{idventas}',[VentasAPI::class, 'obtenerDetalleVentas']);
Route::get('telas',[TelasAPI::class, 'obtenerTelas']);
