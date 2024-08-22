const { Router } = require("express");
const router = Router();

const Telas = require("../controllers/telas");

router.get('/:idusuarios', Telas.ObtenerTelasXUsu);

router.get('/tela/:id', Telas.ObtenerTela);

router.post('/:idusuarios', Telas.RegistrarTela);

router.put('/:id', Telas.ActualizarTela);

router.delete('/:id', Telas.EliminarTela);

module.exports = router;