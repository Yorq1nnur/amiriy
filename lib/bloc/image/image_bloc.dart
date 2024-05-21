import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<UploadImage>(_uploadImage);
    on<UploadAndGetImageUrl>(_uploadAndGetImageUrl);
    on<ChangeInitialState>(_changeInitialState);
  }

  _changeInitialState(ChangeInitialState event, emit) {
    emit(
      ImageInitial(),
    );
  }

  Future<void> _uploadImage(UploadImage event, Emitter<ImageState> emit) async {
    emit(ImageLoading());

    try {
      var ref = FirebaseStorage.instance.ref().child(event.storagePath);
      File file = File(event.pickedFile.path);
      var uploadTask = await ref.putFile(file);
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      emit(ImageSuccess(downloadUrl));
    } on FirebaseException catch (error) {
      emit(ImageFailure(error.toString()));
    }
  }

  Future<void> _uploadAndGetImageUrl(
      UploadAndGetImageUrl event, Emitter<ImageState> emit) async {
    emit(ImageLoading());

    try {
      final storageRef = FirebaseStorage.instance.ref();
      final mountainsRef = storageRef.child(event.filename);
      await mountainsRef.putFile(event.file);
      final mountainImagesRef = storageRef.child("images/${event.filename}");
      String imageUrl = await mountainImagesRef.getDownloadURL();

      emit(ImageSuccess(imageUrl));
    } on FirebaseException catch (e) {
      emit(ImageFailure(e.message ?? ''));
    }
  }
}
