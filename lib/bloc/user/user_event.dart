part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class UpdateUserEvent extends UserEvent {
  final UserModel userModel;

  const UpdateUserEvent(
    this.userModel,
  );

  @override
  List<Object?> get props => [
        userModel,
      ];
}

class AddUserEvent extends UserEvent {
  final UserModel userModel;

  const AddUserEvent({
    required this.userModel,
  });

  @override
  List<Object?> get props => [
        userModel,
      ];
}

class GetUserEvent extends UserEvent {
  final String userId;

  const GetUserEvent({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}
