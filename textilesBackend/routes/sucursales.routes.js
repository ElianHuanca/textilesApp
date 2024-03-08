const { Router } = require("express");
const router = Router();

const Sucursales = require("../controllers/sucursales");

router.get('/:idusuarios', Sucursales.ObtenerSucursales);

router.post('/:idusuarios', Sucursales.RegistrarSucursal);

router.put('/:id', Sucursales.ActualizarSucursal);

router.delete('/:id', Sucursales.EliminarSucursal);

module.exports = router;