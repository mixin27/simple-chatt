import asyncHandler from "express-async-handler";

import Message from "../models/messageModel.js";
import User from "../models/userModel.js";
import Chat from "../models/chatModel.js";

const sendMessage = asyncHandler(async (req, res) => {
  const { content, chatId } = req.body;

  if (!content || !chatId) {
    console.log("Invalid data passed into request");
    return res.sendStatus(400);
  }

  var newMessage = {
    sender: req.user._id,
    content: content,
    chat: chatId,
  };

  try {
    var message = await Message.create(newMessage);

    message = await message.populate("sender", "name email avatar");
    message = await message.populate("chat");
    message = await User.populate(message, {
      path: "chat.users",
      select: "name avatar email",
    });

    await Chat.findByIdAndUpdate(req.body.chatId, {
      latest_message: message,
    });

    res.json({
      data: message,
      success: true,
      message: "success",
    });
  } catch (error) {
    res.status(400);
    throw new Error(error.message);
  }
});

const allMessages = asyncHandler(async (req, res) => {
  try {
    var messages = await Message.find({ chat: req.params.chatId })
      .populate("sender", "name avatar email")
      .populate("chat");

    messages = await User.populate(messages, {
      path: "chat.users",
      select: "name avatar email",
    });

    messages = await Message.populate(messages, {
      path: "chat.latest_message",
    });

    messages = await User.populate(messages, {
      path: "chat.group_admin",
    });

    res.json({
      data: messages,
      success: true,
      message: "success",
    });
  } catch (error) {
    res.status(400);
    throw new Error(error.message);
  }
});

export { sendMessage, allMessages };
