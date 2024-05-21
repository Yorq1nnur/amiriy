import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class ImageEvent {}

class UploadImage extends ImageEvent {
  final XFile pickedFile;
  final String storagePath;

  UploadImage({required this.pickedFile, required this.storagePath});
}

class ChangeInitialState extends ImageEvent {}

class UploadAndGetImageUrl extends ImageEvent {
  final File file;
  final String filename;

  UploadAndGetImageUrl({required this.file, required this.filename});
}
