<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\VentasModelo;
use Illuminate\Http\Request;

class VentasAPI extends Controller
{
    public function obtenerVentas(){
        return VentasModelo::obtenerVentas();
    }

    public function obtenerVenta($id){
        return VentasModelo::obtenerVenta($id);
    }

    public function crearVenta(Request $request){
        $venta = $request->all();
        return VentasModelo::crearVenta($venta);
    }

    public function actualizarVenta(Request $request){
        $venta = $request->all();
        return VentasModelo::actualizarVenta($venta);
    }

    public function eliminarVenta($id){
        return VentasModelo::eliminarVenta($id);
    }
}
