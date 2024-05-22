import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class ListenAllBooksEvent extends BookEvent {
  @override
  List<Object?> get props => [];
}

class GetBooksByCategoryId extends BookEvent {
  final String categoryId;

  const GetBooksByCategoryId({
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        categoryId,
      ];
}
