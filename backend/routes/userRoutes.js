import express from "express";

import {
  allUsers,
  authUser,
  regiseterUser,
} from "../controllers/userControllers.js";
import { protect } from "../middlewares/auth.js";

const router = express.Router();

router.route("/").post(regiseterUser).get(protect, allUsers);
router.post("/login", authUser);

export default router;
