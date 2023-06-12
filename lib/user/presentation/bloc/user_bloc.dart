import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_api/users_api.dart';

import '../../../utils/response_wrapper.dart';
import '../../domain/i_user_repo.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepo _repository;

  UserBloc({required IUserRepo repository})
      : _repository = repository,
        super(const UserState()) {
    on<FetchUserListEvent>(_fetchUserList);
    on<FetchUserByIdEvent>(_fetchUserById);
    on<SendRabbitMQMessageEvent>(_sendRabbitMqMessage);
  }

  FutureOr<void> _fetchUserList(
      FetchUserListEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(state: UiState.loading));

    var resource = await _repository.getUsers();

    switch (resource?.status) {
      case Status.success:
        emit(state.copyWith(state: UiState.success, users: resource?.data));
        break;
      case Status.failed:
        emit(
            state.copyWith(state: UiState.failed, errorMsg: resource?.message));
        break;
      case Status.loading:
      default:
        emit(state.copyWith(state: UiState.loading));
        break;
    }
  }

  FutureOr<void> _fetchUserById(
      FetchUserByIdEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(state: UiState.loading));

    var resource = await _repository.getUsersById(event.id);

    switch (resource?.status) {
      case Status.success:
        emit(state.copyWith(state: UiState.success, user: resource?.data));
        break;
      case Status.failed:
        emit(
            state.copyWith(state: UiState.failed, errorMsg: resource?.message));
        break;
      case Status.loading:
      default:
        emit(state.copyWith(state: UiState.loading));
        break;
    }
  }

  FutureOr<void> _sendRabbitMqMessage(
      SendRabbitMQMessageEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(state: UiState.loading));
    var resource = await _repository.rabbitMqResponse(event.message);

    switch (resource?.status) {
      case Status.success:
        print('UserBloc._sendRabbitMqMessage: ${resource?.data?.messageSent}');
        emit(state.copyWith(
            state: UiState.success, rabbitMQResponse: resource?.data));
        break;
      case Status.failed:
        emit(
            state.copyWith(state: UiState.failed, errorMsg: resource?.message));
        break;
      case Status.loading:
      default:
        emit(state.copyWith(state: UiState.loading));
        break;
    }
  }
}
