import express from "express";

import { protect } from "../middlewares/auth.js";
import {
  accessChat,
  addUserToGroup,
  createGroupChat,
  fetchChats,
  removeUserFromGroup,
  renameGroup,
} from "../controllers/chatControllers.js";

const router = express.Router();

router.route("/").post(protect, accessChat);
router.route("/").get(protect, fetchChats);
router.route("/group").post(protect, createGroupChat);
router.route("/group/rename").put(protect, renameGroup);
router.route("/group/adduser").put(protect, addUserToGroup);
router.route("/group/removeuser").put(protect, removeUserFromGroup);

export default router;
