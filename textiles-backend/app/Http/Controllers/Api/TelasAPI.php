<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\TelasModelo;
use Illuminate\Http\Request;

class TelasAPI extends Controller
{
    public function obtenerTelas(){
        return TelasModelo::obtenerTelas();
    }

    public function obtenerTela($id){
        return TelasModelo::obtenerTela($id);
    }

    public function crearTela(Request $request){
        $tela = $request->all();
        return TelasModelo::crearTela($tela);
    }

    public function actualizarTela(Request $request){
        $tela = $request->all();
        return TelasModelo::actualizarTela($tela);
    }

    public function eliminarTela($id){
        return TelasModelo::eliminarTela($id);
    }

    public function obtenerTelaNombre($nombre){
        return TelasModelo::obtenerTelaNombre($nombre);
    }
}
