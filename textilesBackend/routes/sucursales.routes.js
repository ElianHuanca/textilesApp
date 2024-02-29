const { Router } = require("express");
const router = Router();

const Sucursales = require("../controllers/sucursales");

router.get('/:idusuarios', Sucursales.ObtenerSucursalesXUsuario);
router.post('', Sucursales.RegistrarSucursalXUsuario);

module.exports = router;