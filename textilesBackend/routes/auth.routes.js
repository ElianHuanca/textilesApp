

const { Router } = require("express");
const router = Router();
const Auth = require("../controllers/auth");

router.post('', Auth.login);

module.exports = router;