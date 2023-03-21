import asyncHandler from "express-async-handler";
// for type suggestion
import "express";

import User from "../models/userModel.js";
import { generateToken } from "../config/generateToken.js";

/**
 * Register user
 */
const regiseterUser = asyncHandler(async (req, res) => {
  const { name, email, password, avatar } = req.body;

  if (!name || !email || !password) {
    res.status(400);
    throw new Error("Please provide all the fields.");
  }

  const userExists = await User.findOne({ email });
  if (userExists) {
    res.status(400);
    throw new Error("User already existed.");
  }

  const user = await User.create({
    name,
    email,
    password,
    avatar,
  });

  if (user) {
    res.status(201).json({
      data: {
        user: {
          _id: user._id,
          name: user.name,
          email: user.email,
          avatar: user.avatar,
        },
        token: generateToken(user._id),
      },
      success: true,
      message: "Register successfully.",
    });
  } else {
    res.status(400);
    throw new Error("Failed to create the user.");
  }
});

/**
 * Login user
 */
const authUser = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });

  if (user && (await user.matchPassword(password))) {
    res.json({
      data: {
        user: {
          _id: user._id,
          name: user.name,
          email: user.email,
          avatar: user.avatar,
        },
        token: generateToken(user._id),
      },
      success: true,
      message: "Login successfully.",
    });
  } else {
    res.status(400);
    throw new Error("Invalid email or password.");
  }
});

/**
 * Get all users.
 *
 * /api/user?search=john
 */
const allUsers = asyncHandler(async (req, res) => {
  const keyword = req.query.search
    ? {
        $or: [
          { name: { $regex: req.query.search, $options: "i" } },
          { email: { $regex: req.query.search, $options: "i" } },
        ],
      }
    : {};

  const users = await User.find(keyword).find({ _id: { $ne: req.user._id } });

  res.send({
    data: users,
    success: true,
    message: "success",
  });
});

export { regiseterUser, authUser, allUsers };
