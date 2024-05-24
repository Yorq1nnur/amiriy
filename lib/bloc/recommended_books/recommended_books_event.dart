import 'package:equatable/equatable.dart';

abstract class RecommendedBooksEvent extends Equatable {
  const RecommendedBooksEvent();
}

class GetRecommendedBooksEvent extends RecommendedBooksEvent {
  @override
  List<Object?> get props => [];
}
