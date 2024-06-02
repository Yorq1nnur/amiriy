part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserModel userModel;
  final String errorText;
  final FormStatus formStatus;

  const UserState({
    required this.userModel,
    required this.errorText,
    required this.formStatus,
  });

  UserState copyWith({
    UserModel? userModel,
    String? errorText,
    FormStatus? formStatus,
  }) =>
      UserState(
        userModel: userModel ?? this.userModel,
        errorText: errorText ?? this.errorText,
        formStatus: formStatus ?? this.formStatus,
      );

  static UserState initial() => UserState(
        userModel: UserModel.initial(),
        errorText: '',
        formStatus: FormStatus.pure,
      );

  @override
  List<Object?> get props => [
        userModel,
        errorText,
        formStatus,
      ];
}
