const { Router } = require("express");
const router = Router();

const Telas = require("../controllers/telas");

router.get('/:idusuarios', Telas.ObtenerTelasXUsu);//http:localhost:8080/api/telas/1

router.post('/:idusuarios', Telas.RegistrarTela);

router.put('/:id', Telas.ActualizarTela);

router.delete('/:id', Telas.EliminarTela);

module.exports = router;