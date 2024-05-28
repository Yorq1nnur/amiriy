// import 'package:amiriy/bloc/form_status/form_status.dart';
// import 'package:amiriy/data/models/favourite_book_model.dart';
// import 'package:equatable/equatable.dart';
//
// class FavouriteState extends Equatable {
//   final String errorText;
//   final FormStatus formStatus;
//   final List<FavouriteBookModel> favouritesBooks;
//
//   const FavouriteState({
//     required this.formStatus,
//     required this.errorText,
//     required this.favouritesBooks,
//   });
//
//   static FavouriteState initial() => const FavouriteState(
//         formStatus: FormStatus.pure,
//         errorText: '',
//         favouritesBooks: [],
//       );
//
//   FavouriteState copyWith({
//     String? errorText,
//     FormStatus? formStatus,
//     List<FavouriteBookModel>? favouritesBooks,
//   }) =>
//       FavouriteState(
//         formStatus: formStatus ?? this.formStatus,
//         errorText: errorText ?? this.errorText,
//         favouritesBooks: favouritesBooks ?? this.favouritesBooks,
//       );
//
//   @override
//   List<Object?> get props => [
//         favouritesBooks,
//         formStatus,
//         errorText,
//       ];
// }
