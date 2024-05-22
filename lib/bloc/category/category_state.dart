import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/category_model.dart';
import 'package:equatable/equatable.dart';

class CategoryState extends Equatable {
  final FormStatus formStatus;
  final List<CategoryModel> allCategories;
  final String errorText;
  final String statusMessage;

  const CategoryState({
    required this.formStatus,
    required this.errorText,
    required this.statusMessage,
    required this.allCategories,
  });

  CategoryState copyWith({
    FormStatus? formStatus,
    List<CategoryModel>? allCategories,
    String? errorText,
    String? statusMessage,
  }) =>
      CategoryState(
        formStatus: formStatus ?? this.formStatus,
        errorText: errorText ?? this.errorText,
        statusMessage: statusMessage ?? this.statusMessage,
        allCategories: allCategories ?? this.allCategories,
      );

  static CategoryState initial() => const CategoryState(
        formStatus: FormStatus.pure,
        errorText: '',
        statusMessage: '',
        allCategories: [],
      );

  @override
  List<Object?> get props => [
        formStatus,
        allCategories,
        errorText,
        statusMessage,
      ];
}
