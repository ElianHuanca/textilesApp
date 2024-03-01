const { Router } = require("express");
const router = Router();

const VentaController = require("../controllers/ventas");

router.get('/:idsucursales', VentaController.ObtenerVentasXSuc);
router.post('', VentaController.RegistrarVenta);
router.post('/:idsucursales', VentaController.RegistrarVentaAhora);
module.exports = router;