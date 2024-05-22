import 'package:amiriy/bloc/category/category_event.dart';
import 'package:amiriy/bloc/category/category_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/category_model.dart';
import 'package:amiriy/data/repositories/category_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(
    this.categoryRepo,
  ) : super(
          CategoryState.initial(),
        ) {
    on<GetAllCategoriesEvent>(_getAllCategories);
  }

  CategoryRepo categoryRepo;

  _getAllCategories(
    GetAllCategoriesEvent event,
    Emitter emit,
  ) {
    state.copyWith(
      formStatus: FormStatus.loading,
    );
    emit.onEach(
      categoryRepo.listenCategories(),
      onData: (
        List<CategoryModel> categories,
      ) {
        emit(
          state.copyWith(
            formStatus: FormStatus.success,
            allCategories: categories,
          ),
        );
      },
      onError: (e, s) {
        emit(
          state.copyWith(
            formStatus: FormStatus.error,
            errorText: e.toString(),
          ),
        );
      },
    );
  }
}
