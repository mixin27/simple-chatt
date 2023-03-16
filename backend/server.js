import express, { json } from "express";
import dotenv from "dotenv";
import morgan from "morgan";
import "colors";

import { connectDB } from "./config/db.js";
import { errorHandler, notFound } from "./middlewares/errors.js";

import userRoutes from "./routes/userRoutes.js";
import chatRoutes from "./routes/chatRoutes.js";
import messageRoutes from "./routes/messageRoute.js";

dotenv.config();
connectDB();

const app = express();

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}

// middlewares
app.use(json()); // To accept JSON data

app.get("/api", (req, res) => {
  res.send("Yoyo Chatt API is running...");
});

app.use("/api/user", userRoutes);
app.use("/api/chats", chatRoutes);
app.use("/api/message", messageRoutes);

// errors
app.use(notFound);
app.use(errorHandler);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(
    `🚀 Server running in ${process.env.NODE_ENV} mode on port ${PORT}`.yellow
      .bold
  );
});
