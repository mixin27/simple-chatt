// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:yoyo_chatt/auth/models/credential.dart';
// import 'package:yoyo_chatt/user/repositories/user_repository.dart';

// part 'user_event.dart';
// part 'user_state.dart';
// part 'user_bloc.freezed.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final UserRepository _repository;

//   UserBloc({
//     required UserRepository userRepository,
//   })  : _repository = userRepository,
//         super(const _Initial()) {
//     on<UserStarted>((event, emit) async {
//       final result = await _repository.getUsers();
//       emit(Loaded(result.data ?? []));
//     });
//   }
// }
