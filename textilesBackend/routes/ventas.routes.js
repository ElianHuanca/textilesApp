const { Router } = require("express");
const router = Router();

const VentaController = require("../controllers/ventas");

router.get('/:idsucursales', VentaController.ObtenerVentas);

router.post('', VentaController.RegistrarVenta);

router.post('/:idsucursales', VentaController.RegistrarVentaAhora);

router.get('/grafica1/:idusuarios', VentaController.ventasTotalesPorSucursal);
module.exports = router;