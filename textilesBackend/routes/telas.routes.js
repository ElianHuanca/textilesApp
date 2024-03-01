const { Router } = require("express");
const router = Router();

const Telas = require("../controllers/telas");

router.get('/:idusuarios', Telas.ObtenerTelasXUsu);

module.exports = router;