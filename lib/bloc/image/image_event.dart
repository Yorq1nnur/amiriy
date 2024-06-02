part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class UploadImage extends ImageEvent {
  final XFile pickedFile;
  final String storagePath;

  UploadImage({required this.pickedFile, required this.storagePath});
}

class ChangeInitialState extends ImageEvent {}

class GetFromCameraEvent extends ImageEvent {}

class GetFromGalleryEvent extends ImageEvent {}

class UploadAndGetImageUrl extends ImageEvent {
  final File file;
  final String filename;

  UploadAndGetImageUrl({required this.file, required this.filename});
}
