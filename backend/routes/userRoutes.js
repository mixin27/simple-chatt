import express from "express";

import { authUser, regiseterUser } from "../controllers/userControllers.js";

const router = express.Router();

router.route("/").post(regiseterUser);
router.post("/login", authUser);

export default router;
