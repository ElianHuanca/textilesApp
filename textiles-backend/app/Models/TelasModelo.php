<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TelasModelo extends Model
{
    protected $fillable = ['nombre', 'precxmay', 'precxmen', 'precxrollo', 'precxcompra'];
    use HasFactory;

    public function obtenerTelas(){
        $telas = TelasModelo::all();
        return $telas;
    }

    public function obtenerTela($id){
        $tela = TelasModelo::find($id);
        return $tela;
    }

    public function crearTela($tela){
        $tela = TelasModelo::create($tela);
        return $tela;
    }

    public function actualizarTela($tela){
        $tela = TelasModelo::find($tela['id']);
        $tela->nombre = $tela['nombre'];
        $tela->precxmay = $tela['precxmay'];
        $tela->precxmen = $tela['precxmen'];
        $tela->precxrollo = $tela['precxrollo'];
        $tela->precxcompra = $tela['precxcompra'];
        $tela->save();
        return $tela;
    }

    public function eliminarTela($id){
        $tela = TelasModelo::find($id);
        $tela->delete();
        return $tela;
    }

    public function obtenerTelaNombre($nombre){
        $tela = TelasModelo::where('nombre', $nombre)->first();
        return $tela;
    }

    public function detalleVenta()
    {
        return $this->hasOne(DetVentasModelo::class, 'idtelas');
    }
}
