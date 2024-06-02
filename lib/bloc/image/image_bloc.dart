import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_state.dart';

part 'image_event.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<UploadImage>(_uploadImage);
    on<ChangeInitialState>(_changeInitialState);
    on<GetFromCameraEvent>(getImageFromCamera);
    on<GetFromGalleryEvent>(getImageFromGallery);
  }
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";
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

  Future<void> getImageFromGallery(GetFromGalleryEvent event, emit) async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      add(
        UploadImage(
          pickedFile: image,
          storagePath: "files/images/${image.name}",
        ),
      );
      image = XFile('');
      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> getImageFromCamera(GetFromCameraEvent event, emit) async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      add(
        UploadImage(
          pickedFile: image,
          storagePath: "files/images/${image.name}",
        ),
      );
      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }
}
