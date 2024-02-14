<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\VentasModelo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VentasAPI extends Controller
{
    public function obtenerVentas()
    {
        return VentasModelo::orderBy('fecha', 'desc')->get();
    }

    public function obtenerDetalleVentas($idventas)
    {
        $consulta = "SELECT t.id, t.nombre, dv.cantidad, dv.precio, dv.total
             FROM det_ventas dv 
             INNER JOIN telas t ON dv.idtelas = t.id 
             WHERE dv.idventas = ?
             ORDER BY t.id DESC";


        $detalles = DB::select($consulta, [$idventas]);

        return $detalles;
    }

    public function obtenerVenta($id)
    {
        return VentasModelo::obtenerVenta($id);
    }

    public function crearVenta(Request $request)
    {
        $venta = $request->all();
        return VentasModelo::crearVenta($venta);
    }

    public function actualizarVenta(Request $request)
    {
        $venta = $request->all();
        return VentasModelo::actualizarVenta($venta);
    }

    public function eliminarVenta($id)
    {
        return VentasModelo::eliminarVenta($id);
    }
}
