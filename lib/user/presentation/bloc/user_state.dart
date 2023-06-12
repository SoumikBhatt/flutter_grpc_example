part of 'user_bloc.dart';


class UserState extends Equatable {

  final UiState state;
  final List<User> users;
  final User? user;
  final String errorMsg;
  final RabbitMQResponse? rabbitMQResponse;

  const UserState({
    this.state = UiState.loading,
    this.users = const <User>[],
    this.errorMsg = "",
    this.user,
    this.rabbitMQResponse,
  });

  UserState copyWith({
    required UiState state,
    List<User>? users,
    String? errorMsg,
    User? user,
    RabbitMQResponse? rabbitMQResponse
}) {
    return UserState(
      state: state,
      users: users??this.users,
      errorMsg: errorMsg??this.errorMsg,
      user: user,
      rabbitMQResponse: rabbitMQResponse,
    );
  }

  @override
  List<Object?> get props => [state,users,errorMsg,user,rabbitMQResponse];

}

enum UiState {success, loading, failed}
