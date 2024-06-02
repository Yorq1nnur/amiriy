import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/data/models/user_model.dart';
import 'package:amiriy/data/repositories/user_repo.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this.userRepo,
  ) : super(
          UserState.initial(),
        ) {
    on<AddUserEvent>(_addUser);
    on<GetUserEvent>(_getUser);
    on<UpdateUserEvent>(_updateUser);
  }

  final UserRepo userRepo;

  _updateUser(UpdateUserEvent event, emit) async {
    UtilityFunctions.methodPrint(
      'ON UPDATE USER BLOC IMAGE IS: ${event.userModel.imageUrl}',
    );
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse =
        await userRepo.updateUser(event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _getUser(GetUserEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await userRepo.getUser(
      event.userId,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          userModel: networkResponse.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }

  _addUser(AddUserEvent event, emit) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.loading,
      ),
    );

    NetworkResponse networkResponse = await userRepo.addUser(
      event.userModel,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formStatus: FormStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }
}
