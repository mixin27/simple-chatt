import React from "react";
import ScrollableFeed from "react-scrollable-feed";
import {
  isLastMessage,
  isSameSender,
  isSameSenderMargin,
  isSameUser,
} from "../../config/chat-logics";
import { useChatState } from "../../context/ChatProvider";
import { Avatar, Tooltip } from "@chakra-ui/react";

const ScrollableChat = ({ messages }) => {
  const { user } = useChatState();

  console.log(messages);

  return (
    <ScrollableFeed>
      {messages &&
        messages.map((msg, idx) => (
          <div
            key={msg._id}
            style={{
              display: "flex",
            }}
          >
            {(isSameSender(messages, msg, idx, user.data.user._id) ||
              isLastMessage(messages, idx, user.data.user._id)) && (
              <Tooltip
                label={msg.sender.name}
                placement="bottom-start"
                hasArrow
              >
                <Avatar
                  mt="7px"
                  mr={1}
                  size="sm"
                  cursor="pointer"
                  src={msg.sender.avatar}
                />
              </Tooltip>
            )}

            <span
              style={{
                backgroundColor: `${
                  msg.sender._id === user.data.user._id ? "#BEE3F8" : "#B9F5D0"
                }`,
                borderRadius: "20px",
                padding: "5px 15px",
                maxWidth: "75%",
                marginLeft: isSameSenderMargin(
                  messages,
                  msg,
                  idx,
                  user.data.user._id
                ),
                marginTop: isSameUser(messages, msg, idx) ? 3 : 10,
              }}
            >
              {msg.content}
            </span>
          </div>
        ))}
    </ScrollableFeed>
  );
};

export default ScrollableChat;
