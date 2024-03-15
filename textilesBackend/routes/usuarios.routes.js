const { Router } = require("express");
const router = Router();

const UsuarioController = require("../controllers/usuarios");

router.get('', UsuarioController.ObtenerUsuarios);
router.post('', UsuarioController.registrarUsuario);
router.put('/:id', UsuarioController.actualizarUsuario);
module.exports = router;