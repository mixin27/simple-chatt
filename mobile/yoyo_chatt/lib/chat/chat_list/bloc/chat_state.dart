// part of 'chat_bloc.dart';

// @freezed
// class ChatState with _$ChatState {
//   const ChatState._();

//   const factory ChatState({
//     required List<ChatEntity> chats,
//     required List<String> chatMessages,
//     ChatEntity? selectedChat,
//     required DataStatus status,
//     required String message,
//     String? otherUserId,
//     required bool isLastPage,
//     required int page,
//   }) = _ChatState;

//   factory ChatState.initial() {
//     return const ChatState(
//       chats: [],
//       selectedChat: null,
//       chatMessages: [],
//       status: DataStatus.initial,
//       message: "",
//       otherUserId: null,
//       isLastPage: false,
//       page: 1,
//     );
//   }

//   bool get isSearchChat => otherUserId != null && selectedChat == null;

//   bool get isListChat => otherUserId == null && selectedChat != null;
// }
