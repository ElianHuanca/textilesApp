const { Router } = require("express");
const router = Router();

const DetalleVentaController = require("../controllers/det_ventas");

router.get('/:idventas', DetalleVentaController.ObtenerDetVentas);
router.post('/:idventas', DetalleVentaController.RegistrarDetVentas);

module.exports = router;