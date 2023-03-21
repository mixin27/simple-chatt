// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:yoyo_chatt/auth/models/credential.dart';
// import 'package:yoyo_chatt/chat/chat_list/models/chat_model.dart';
// import 'package:yoyo_chatt/chat/chat_list/models/requests/create_chat_request.dart';
// import 'package:yoyo_chatt/chat/chat_list/repositories/chat_repository.dart';
// import 'package:yoyo_chatt/core/enum/data_status.dart';

// part 'chat_event.dart';
// part 'chat_state.dart';
// part 'chat_bloc.freezed.dart';

// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final ChatRepository _chatRepository;

//   ChatBloc({
//     required ChatRepository chatRepository,
//   })  : _chatRepository = chatRepository,
//         super(ChatState.initial()) {
//     // chat started
//     on<ChatStarted>((event, emit) async {
//       if (state.status.isLoading) return;

//       emit(state.copyWith(status: DataStatus.loading));

//       final result = await _chatRepository.getChats();

//       emit(state.copyWith(
//         status: DataStatus.loaded,
//         chats: result.success ? result.data ?? [] : [],
//       ));
//     });

//     // chat reset
//     on<ChatReset>((event, emit) {
//       emit(state.copyWith(
//         chatMessages: [],
//         message: '',
//         status: DataStatus.initial,
//         selectedChat: null,
//         otherUserId: null,
//         isLastPage: false,
//         page: 1,
//         chats: (event.shouldResetChat != null && event.shouldResetChat!)
//             ? []
//             : state.chats,
//       ));
//     });

//     // user selected
//     on<UserSelected>((event, emit) {
//       emit(state.copyWith(otherUserId: event.user.id));
//     });

//     // chat selected
//     on<ChatSelected>((event, emit) {
//       emit(state.copyWith(selectedChat: event.chat));
//     });

//     // get chat message
//     on<GetChatMessage>((event, emit) async {
//       if (state.status.isFetching) return;

//       emit(state.copyWith(status: DataStatus.fetching));

//       ChatEntity? chat;

//       if (!event.isGroupChat) {
//         final chatResult = await _chatRepository.createOrAccessChat(
//           CreateChatRequest(userId: state.otherUserId!),
//         );

//         if (chatResult.success) {
//           chat = chatResult.data;
//         }
//       } else {}

//       if (chat == null) {
//         emit(state.copyWith(
//           chatMessages: [],
//           status: DataStatus.loaded,
//         ));
//         return;
//       }

//       // TODO: to get chat messages
//     });
//   }
// }
