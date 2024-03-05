const { Router } = require("express");
const router = Router();

const VentaController = require("../controllers/ventas");

router.get('/:idsucursales', VentaController.ObtenerVentas);
router.post('', VentaController.RegistrarVenta);
router.post('/:idsucursales', VentaController.RegistrarVentaAhora);
router.delete('/:id', VentaController.EliminarVenta);
router.put('', VentaController.EliminarVenta0);
module.exports = router;