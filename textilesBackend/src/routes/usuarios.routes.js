const { Router } = require("express");
const router = Router();

const UsuarioController = require("../controllers/usuarioController");

router.get('', UsuarioController.ObtenerUsuariosQuery);

module.exports = router;