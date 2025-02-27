const { Router } = require("express");
const router = Router();

const DetalleVentaController = require("../controllers/det_ventas");

router.get('/:idventas', DetalleVentaController.ObtenerDetVentas);
router.post('/:idventas', DetalleVentaController.RegistrarDetVentas);
router.delete('/:id', DetalleVentaController.eliminarDetVenta);
router.post('/ventasxtela/:idusuarios', DetalleVentaController.ventasxtela);
module.exports = router;