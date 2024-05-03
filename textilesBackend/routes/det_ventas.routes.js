const { Router } = require("express");
const router = Router();

const DetalleVentaController = require("../controllers/det_ventas");

router.get('/:idventas', DetalleVentaController.ObtenerDetVentas);
router.post('/:idventas/:descuento', DetalleVentaController.RegistrarDetVentas);
router.delete('/:id', DetalleVentaController.eliminarDetVenta);
module.exports = router;