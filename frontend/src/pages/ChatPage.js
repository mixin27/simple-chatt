import React, { useState } from "react";
import { Box } from "@chakra-ui/react";

import { useChatState } from "../context/ChatProvider";
import SideDrawer from "../components/common/SideDrawer";
import ChatList from "../components/Chat/ChatList";
import ChatBox from "../components/Chat/ChatBox";

const ChatPage = () => {
  const { user } = useChatState();

  const [fetchAgain, setFetchAgain] = useState(false);

  return (
    <div style={{ width: "100%" }}>
      {user && <SideDrawer />}
      <Box
        display="flex"
        justifyContent="space-between"
        w="100%"
        h="91.5vh"
        p="10px"
      >
        {user && <ChatList fetchAgain={fetchAgain} />}
        {user && (
          <ChatBox fetchAgain={fetchAgain} setFetchAgain={setFetchAgain} />
        )}
      </Box>
    </div>
  );
};

export default ChatPage;
