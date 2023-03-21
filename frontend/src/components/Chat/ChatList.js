import React, { useState, useEffect } from "react";
import { useToast, Box, Button, Stack, Text } from "@chakra-ui/react";
import { AddIcon } from "@chakra-ui/icons";
import axios from "axios";

import { useChatState } from "../../context/ChatProvider";
import ChatLoading from "../common/ChatLoading";
import GroupChatModal from "../common/GroupChatModal";
import { getSender } from "../../config/chat-logics";

const ChatList = ({ fetchAgain }) => {
  const { selectedChat, setSelectedChat, user, chats, setChats } =
    useChatState();

  const toast = useToast();

  const [loggedUser, setLoggedUser] = useState();

  const fetchChats = async () => {
    try {
      const config = {
        headers: {
          Authorization: `Bearer ${user.data.token}`,
        },
      };

      const { data } = await axios.get("/api/chats", config);
      console.log(data);
      setChats(data.data);
    } catch (error) {
      toast({
        title: "Error occurred!",
        description: error.message || "Failed to load the chats",
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });
    }
  };

  useEffect(() => {
    setLoggedUser(JSON.parse(localStorage.getItem("userInfo")));
    console.log(loggedUser);
    fetchChats();

    // eslint-disable-next-line
  }, [fetchAgain]);

  return (
    <Box
      diplay={{ base: selectedChat ? "none" : "flex", md: "flex" }}
      flexDir="column"
      alignItems="center"
      p={3}
      bg="white"
      w={{ base: "100%", md: "31%" }}
      borderRadius="lg"
      borderWidth="1px"
    >
      <Box
        pb={3}
        px={3}
        fontSize={{ base: "28px", md: "30px" }}
        fontFamily="Work sans"
        display="flex"
        w="100%"
        justifyContent="space-between"
        alignItems="center"
      >
        Chats
        <GroupChatModal>
          <Button
            display="flex"
            fontSize={{ base: "17px", md: "10px", lg: "17px" }}
            rightIcon={<AddIcon />}
          >
            New Group
          </Button>
        </GroupChatModal>
      </Box>

      <Box
        display="flex"
        flexDir="column"
        p={3}
        bg="#F8F8F8"
        w="100%"
        h="100%"
        borderRadius="lg"
        overflowY="hidden"
      >
        {chats ? (
          <Stack overflowY="scroll">
            {chats.map((chat) => (
              <Box
                onClick={() => setSelectedChat(chat)}
                cursor="pointer"
                bg={selectedChat === chat ? "#38B2AC" : "#E8E8E8"}
                color={selectedChat === chat ? "white" : "black"}
                px={3}
                py={2}
                borderRadius="lg"
                key={chat._id}
              >
                <Text>
                  {!chat.is_group_chat
                    ? getSender(loggedUser.data, chat.users)
                    : chat.name}
                </Text>

                {chat.latest_message && (
                  <Text>
                    <b>{chat.latest_message.sender.name} : </b>
                    {chat.latest_message.content.length > 50
                      ? chat.latest_message.content.substring(0, 51) + "..."
                      : chat.latest_message.content}
                  </Text>
                )}
              </Box>
            ))}
          </Stack>
        ) : (
          <ChatLoading />
        )}
      </Box>
    </Box>
  );
};

export default ChatList;
