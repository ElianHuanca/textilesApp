<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VentasModelo extends Model
{
    use HasFactory;

    protected $table = 'ventas';
    
    protected $fillable = ['fecha', 'total', 'ganancias'];

    public function detallesVenta()
    {
        return $this->hasMany(DetVentasModelo::class, 'idventas');
    }

    public function obtenerVentas(){
        $ventas = VentasModelo::all();
        return $ventas;
    }

    public function obtenerVenta($id){
        $venta = VentasModelo::find($id);
        return $venta;
    }

    public function crearVenta($venta){
        $venta = VentasModelo::create($venta);
        return $venta;
    }

    public function actualizarVenta($venta){
        $venta = VentasModelo::find($venta['id']);
        $venta->fecha = $venta['fecha'];
        $venta->total = $venta['total'];
        $venta->ganancias = $venta['ganancias'];
        $venta->save();
        return $venta;
    }

    public function eliminarVenta($id){
        $venta = VentasModelo::find($id);
        $venta->delete();
        return $venta;
    }

    public function obtenerVentaFecha($fecha){
        $venta = VentasModelo::where('fecha', $fecha)->first();
        return $venta;
    }
}
