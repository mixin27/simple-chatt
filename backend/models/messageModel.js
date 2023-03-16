import mongoose from "mongoose";
import mongooseAutoPopulate from "mongoose-autopopulate";

const messageSchema = new mongoose.Schema(
  {
    sender: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      autopopulate: true,
    },
    content: { type: String, trim: true },
    chat: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Chat",
      autopopulate: true,
    },
  },
  {
    timestamps: true,
  }
);

messageSchema.plugin(mongooseAutoPopulate);

const Message = mongoose.model("Message", messageSchema);

export default Message;
