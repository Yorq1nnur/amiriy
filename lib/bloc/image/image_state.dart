abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageSuccess extends ImageState {
  final String imageUrl;

  ImageSuccess(this.imageUrl);
}

class ImageFailure extends ImageState {
  final String error;

  ImageFailure(this.error);
}
