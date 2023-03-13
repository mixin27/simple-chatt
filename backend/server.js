import express, { json } from "express";
import dotenv from "dotenv";

import { chats } from "./data/data.js";

dotenv.config();

const app = express();

// middlewares
app.use(json());

app.get("/", (req, res) => {
  res.send("Yoyo Chatt API is running...");
});

app.get("/api/chat", (req, res) => {
  res.send(chats);
});

app.get("/api/chat/:id", (req, res) => {
  const { id } = req.params;

  const singleChat = chats.find((c) => c._id === id);

  res.send(singleChat);
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
