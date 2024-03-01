

const { Router } = require("express");
const router = Router();
const Auth = require("../controllers/auth");

router.post('', Auth.login);
router.post('/check-status', Auth.checkStatus);

module.exports = router;