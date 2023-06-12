part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUserListEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class FetchUserByIdEvent extends UserEvent {
  final String id;

  const FetchUserByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SendRabbitMQMessageEvent extends UserEvent {
  final String message;

  const SendRabbitMQMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];


}
