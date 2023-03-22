import asyncHandler from "express-async-handler";
// for type suggestion
import "express";

import Chat from "../models/chatModel.js";
import User from "../models/userModel.js";

const accessChat = asyncHandler(async (req, res) => {
  const { userId } = req.body;

  if (!userId) {
    console.log("UserId param not sent with request");
    return res.sendStatus(400);
  }

  var isChat = await Chat.find({
    is_group_chat: false,
    $and: [
      { users: { $elemMatch: { $eq: req.user._id } } },
      { users: { $elemMatch: { $eq: userId } } },
    ],
  })
    .populate("users", "-password")
    .populate("latest_message");

  isChat = await User.populate(isChat, {
    path: "latest_message.sender",
    select: "name avatar email",
  });

  if (isChat.length > 0) {
    res.send({
      data: isChat[0],
      success: true,
      message: "success",
    });
  } else {
    var chatData = {
      name: "sender",
      is_group_chat: false,
      users: [req.user._id, userId],
    };

    try {
      const createdChat = await Chat.create(chatData);

      const fullChat = await Chat.findOne({ _id: createdChat._id }).populate(
        "users",
        "-password"
      );

      res.status(200).json({
        data: fullChat,
        success: true,
        message: "success",
      });
    } catch (err) {
      res.status(400);
      throw new Error(err.message);
    }
  }
});

/**
 * Get chats
 */
const fetchChats = asyncHandler(async (req, res) => {
  try {
    Chat.find({ users: { $elemMatch: { $eq: req.user._id } } })
      .populate("users", "-password")
      .populate("group_admin", "-password")
      .populate("latest_message")
      .sort({ updatedAt: -1 })
      .then(async (results) => {
        results = await User.populate(results, {
          path: "latest_message.sender",
          select: "name avatar email",
        });

        res.status(200).json({
          data: results,
          success: true,
          message: "success",
        });
      });
  } catch (err) {
    res.status(400);
    throw new Error(err.message);
  }
});

/**
 * Create agroup
 */
const createGroupChat = asyncHandler(async (req, res) => {
  if (!req.body.users || !req.body.name) {
    res.status(400);
    throw new Error("Please provide all the fields.");
  }

  var users = JSON.parse(req.body.users);
  if (users.length < 2) {
    res.status(400);
    throw new Error("More than 2 users are required to form a group chat.");
  }

  users.push(req.user);

  try {
    const groupChat = await Chat.create({
      name: req.body.name,
      users: users,
      is_group_chat: true,
      group_admin: req.user,
    });

    const fullGroupChat = await Chat.findOne({ _id: groupChat._id })
      .populate("users", "-password")
      .populate("group_admin", "-password");

    res.status(200).json({
      data: fullGroupChat,
      success: true,
      message: "success",
    });
  } catch (err) {
    res.status(400);
    throw new Error(err.message);
  }
});

/**
 * Rename group name
 */
const renameGroup = asyncHandler(async (req, res) => {
  const { chatId, chatName } = req.body;

  //   if (!chatId || !chatName) {
  //     res.status(400);
  //     throw new Error("Please provide required fields.");
  //   }

  const updatedChat = await Chat.findByIdAndUpdate(
    chatId,
    { name: chatName },
    { new: true }
  )
    .populate("users", "-password")
    .populate("group_admin", "-password");

  if (!updatedChat) {
    res.status(404);
    throw new Error("Chat no found.");
  } else {
    res.json({
      data: updatedChat,
      success: true,
      message: "success",
    });
  }
});

const addUserToGroup = asyncHandler(async (req, res) => {
  const { chatId, userId } = req.body;

  const added = await Chat.findByIdAndUpdate(
    chatId,
    {
      $push: { users: userId },
    },
    { new: true }
  )
    .populate("users", "-password")
    .populate("group_admin", "-password");

  if (!added) {
    res.status(404);
    throw new Error("Chat not found.");
  } else {
    res.json({
      data: added,
      success: true,
      message: "success",
    });
  }
});

const removeUserFromGroup = asyncHandler(async (req, res) => {
  const { chatId, userId } = req.body;

  const removed = await Chat.findByIdAndUpdate(
    chatId,
    {
      $pull: { users: userId },
    },
    { new: true }
  )
    .populate("users", "-password")
    .populate("group_admin", "-password");

  if (!removed) {
    res.status(404);
    throw new Error("Chat not found.");
  } else {
    res.json({
      data: removed,
      success: true,
      message: "success",
    });
  }
});

export {
  accessChat,
  fetchChats,
  createGroupChat,
  renameGroup,
  addUserToGroup,
  removeUserFromGroup,
};
