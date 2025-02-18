const { Router } = require("express");
const router = Router();

const VentaController = require("../controllers/ventas");

router.get('/:idsucursales', VentaController.ObtenerVentas);

router.get('/venta/:id', VentaController.ObtenerVenta);

router.post('', VentaController.RegistrarVenta);

router.post('/:idsucursales',VentaController.RegistrarVentaAhora);

router.put('/:id', VentaController.ActualizarVenta);

module.exports = router;