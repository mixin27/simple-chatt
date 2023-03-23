import React, { useState } from "react";
import {
  Button,
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  useDisclosure,
  IconButton,
  useToast,
  Box,
  FormControl,
  Input,
  Spinner,
} from "@chakra-ui/react";
import { ViewIcon } from "@chakra-ui/icons";
import { useChatState } from "../../context/ChatProvider";
import UserBadgeItem from "../UserAvatar/UserBadgeItem";
import axios from "axios";
import UserListItem from "../UserAvatar/UserListItem";

const UpdateGroupChatModal = ({ fetchAgain, setFetchAgain, fetchMessages }) => {
  const { isOpen, onOpen, onClose } = useDisclosure();

  const [groupChatName, setGroupChatName] = useState();
  // const [search, setSearch] = useState("");
  const [searchResult, setSearchResult] = useState([]);
  const [loading, setLoading] = useState(false);
  const [renameLoading, setRenameLoading] = useState(false);

  const { selectedChat, setSelectedChat, user } = useChatState();

  const toast = useToast();

  const removeUser = async (userToRemove) => {
    if (
      selectedChat.group_admin._id !== user.data._id &&
      userToRemove._id !== user.data._id
    ) {
      toast({
        title: "Only admin can remove someone!",
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });
      return;
    }

    try {
      setLoading(true);

      const config = {
        headers: {
          Authorization: `Bearer ${user.token}`,
        },
      };

      const { data } = await axios.put(
        "/api/chats/group/removeuser",
        {
          chatId: selectedChat._id,
          userId: userToRemove._id,
        },
        config
      );

      userToRemove._id === user.data._id
        ? setSelectedChat()
        : setSelectedChat(data.data);
      setFetchAgain(!fetchAgain);
      fetchMessages();
      setLoading(false);
    } catch (error) {
      console.log(error);
      toast({
        title: "Error occurred!",
        description: error.message,
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });
      setLoading(false);
    }
  };

  const handleRename = async (e) => {
    e.preventDefault();

    if (!groupChatName) return;

    try {
      setRenameLoading(true);

      const config = {
        headers: {
          Authorization: `Bearer ${user.token}`,
        },
      };

      const { data } = await axios.put(
        "/api/chats/group/rename",
        { chatId: selectedChat._id, chatName: groupChatName },
        config
      );

      setSelectedChat(data.data);
      setFetchAgain(!fetchAgain);
      setRenameLoading(false);
    } catch (error) {
      toast({
        title: "Error occurred!",
        description: error.message,
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });
      setRenameLoading(false);
    }

    setGroupChatName("");
  };

  const handleAddUser = async (userToAdd) => {
    if (selectedChat.users.find((u) => u._id === userToAdd._id)) {
      toast({
        title: "User already in group!",
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });

      return;
    }

    if (selectedChat.group_admin._id !== user.data._id) {
      toast({
        title: "Only admin can add someone!",
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });

      return;
    }

    try {
      setLoading(true);

      const config = {
        headers: {
          Authorization: `Bearer ${user.token}`,
        },
      };

      const { data } = await axios.put(
        "/api/chats/group/adduser",
        {
          chatId: selectedChat._id,
          userId: userToAdd._id,
        },
        config
      );

      setSelectedChat(data.data);
      setFetchAgain(!fetchAgain);
      setLoading(false);
    } catch (error) {
      toast({
        title: "Error occurred!",
        description: error.message,
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });
      setLoading(false);
    }
  };

  const handleSearch = async (search) => {
    if (!search) {
      toast({
        title: "Please enter someting in search",
        status: "warning",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });
      return;
    }

    try {
      setLoading(true);

      const config = {
        headers: {
          Authorization: `Bearer ${user.token}`,
        },
      };

      const { data } = await axios.get(`/api/user?search=${search}`, config);

      setLoading(false);
      setSearchResult(data.data);
    } catch (err) {
      toast({
        title: err.message || "Error occurred!",
        description: "Failed to load the search results.",
        status: "error",
        duration: 5000,
        isClosable: true,
        position: "top-right",
      });
      setLoading(false);
    }
  };

  return (
    <>
      <IconButton
        display={{ base: "flex" }}
        icon={<ViewIcon />}
        onClick={onOpen}
      />

      <Modal isOpen={isOpen} onClose={onClose} isCentered>
        <ModalOverlay />
        <ModalContent>
          <ModalHeader
            fontSize="35px"
            fontFamily="Work sans"
            display="flex"
            justifyContent="center"
          >
            {selectedChat.name}
          </ModalHeader>
          <ModalCloseButton />
          <ModalBody>
            <Box w="100%" display="flex" flexWrap="wrap" pb={3}>
              {selectedChat.users.map((u) => (
                <UserBadgeItem
                  key={u._id}
                  user={u}
                  handleFunction={() => removeUser(u)}
                />
              ))}
            </Box>

            <FormControl display="flex">
              <Input
                placeholder="Group name"
                mb={3}
                value={groupChatName}
                onChange={(e) => setGroupChatName(e.target.value)}
              />
              <Button
                variant="solid"
                colorScheme="teal"
                ml={1}
                isLoading={renameLoading}
                onClick={handleRename}
              >
                Update
              </Button>
            </FormControl>
            <FormControl>
              <Input
                placeholder="Add user to group"
                mb={1}
                onChange={(e) => handleSearch(e.target.value)}
              />
            </FormControl>
            {loading ? (
              <Spinner size="lg" />
            ) : (
              searchResult?.map((user) => (
                <UserListItem
                  key={user._id}
                  user={user}
                  handleFunction={() => handleAddUser(user)}
                />
              ))
            )}
          </ModalBody>

          <ModalFooter>
            <Button colorScheme="red" onClick={() => removeUser(user)}>
              Leave Group
            </Button>
          </ModalFooter>
        </ModalContent>
      </Modal>
    </>
  );
};

export default UpdateGroupChatModal;
