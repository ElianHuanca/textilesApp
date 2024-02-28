const { Router } = require("express");
const router = Router();

const UsuarioController = require("../controllers/usuarios");

router.get('', UsuarioController.ObtenerUsuarios);
router.post('', UsuarioController.registrarUsuario);

module.exports = router;