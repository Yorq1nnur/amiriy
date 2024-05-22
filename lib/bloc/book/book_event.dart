import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class ListenAllBooksEvent extends BookEvent {
  @override
  List<Object?> get props => [];
}
