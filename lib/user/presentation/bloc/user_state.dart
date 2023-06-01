part of 'user_bloc.dart';


class UserState extends Equatable {

  final UiState state;
  final List<User> users;
  final User? user;
  final String errorMsg;

  const UserState({
    this.state = UiState.loading,
    this.users = const <User>[],
    this.errorMsg = "",
    this.user
  });

  UserState copyWith({
    required UiState state,
    List<User>? users,
    String? errorMsg,
    User? user,
}) {
    return UserState(
      state: state,
      users: users??this.users,
      errorMsg: errorMsg??this.errorMsg,
      user: user
    );
  }

  @override
  List<Object?> get props => [state,users,errorMsg,user];

}

enum UiState {success, loading, failed}
