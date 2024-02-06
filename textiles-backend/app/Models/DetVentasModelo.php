<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetVentasModelo extends Model
{
    use HasFactory;

    protected $fillable = ['idventas', 'idtelas', 'precio', 'cantidad'];

    public function venta()
    {
        return $this->belongsTo(VentasModelo::class, 'idventas');
    }

    public function tela()
    {
        return $this->belongsTo(TelasModelo::class, 'idtelas');
    }

    public function obtenerDetallesVentas(){
        $detallesVentas = DetVentasModelo::all();
        return $detallesVentas;
    }

    public function obtenerDetalleVenta($id){
        $detalleVenta = DetVentasModelo::find($id);
        return $detalleVenta;
    }

    public function crearDetalleVenta($detalleVenta){
        $detalleVenta = DetVentasModelo::create($detalleVenta);
        return $detalleVenta;
    }

    public function actualizarDetalleVenta($detalleVenta){
        $detalleVenta = DetVentasModelo::find($detalleVenta['id']);
        $detalleVenta->idventas = $detalleVenta['idventas'];
        $detalleVenta->idtelas = $detalleVenta['idtelas'];
        $detalleVenta->precio = $detalleVenta['precio'];
        $detalleVenta->cantidad = $detalleVenta['cantidad'];
        $detalleVenta->save();
        return $detalleVenta;
    }

    public function eliminarDetalleVenta($id){
        $detalleVenta = DetVentasModelo::find($id);
        $detalleVenta->delete();
        return $detalleVenta;
    }

    
}
