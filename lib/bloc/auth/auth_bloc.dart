import 'package:amiriy/bloc/auth/auth_event.dart';
import 'package:amiriy/bloc/auth/auth_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/local/storage_repository.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/data/models/user_model.dart';
import 'package:amiriy/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthState.init()) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
    on<LogOutUserEvent>(_logOutUser);
  }

  final AuthRepository authRepository;

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    debugPrint("CURRENT USER:$user");
    if (user == null) {
      emit(state.copyWith(status: FormStatus.unauthenticated));
    } else {
      emit(state.copyWith(status: FormStatus.authenticated));
    }
  }

  _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    NetworkResponse networkResponse =
        await authRepository.logInWithEmailAndPassword(
      email: "${event.phoneNumber}@gmail.com",
      password: event.password,
    );
    if (networkResponse.errorText.isEmpty) {
      String? myToken = await FirebaseMessaging.instance.getToken();
      StorageRepository.setString(key: "fc_token", value: myToken ?? "");
      UserCredential userCredential = networkResponse.data as UserCredential;

      UserModel userModel =
          state.userModel.copyWith(authUid: userCredential.user!.uid);

      emit(state.copyWith(
          status: FormStatus.authenticated, userModel: userModel));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    NetworkResponse networkResponse =
        await authRepository.registerWithEmailAndPassword(
      email: "${event.userModel.phoneNumber}@gmail.com",
      password: event.userModel.password,
    );
    if (networkResponse.errorText.isEmpty) {
      // debugPrint("REGISTERED USER!!!");
      String? myToken = await FirebaseMessaging.instance.getToken();
      debugPrint("MyToken: $myToken  -------");
      StorageRepository.setString(key: "fc_token", value: myToken ?? "");
      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel =
          event.userModel.copyWith(authUid: userCredential.user!.uid);
      emit(
        state.copyWith(
          status: FormStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel,
        ),
      );
    } else {
      // debugPrint("ERROR REGISTER USER!!! ${networkResponse.errorCode}");
      emit(
        state.copyWith(
          status: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _googleSignIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    NetworkResponse networkResponse = await authRepository.googleSignIn();
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(
        state.copyWith(
          statusMessage: "registered",
          status: FormStatus.authenticated,
          userModel: UserModel(
            authUid: userCredential.user!.uid,
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            userId: "",
            username: userCredential.user!.displayName ?? "",
            password: '',
            imageUrl: '',
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _logOutUser(LogOutUserEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    await authRepository.logOutUser();
    emit(state.copyWith(status: FormStatus.unauthenticated));
  }
}
