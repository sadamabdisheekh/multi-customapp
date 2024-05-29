import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/models/category.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import 'package:multi/data/repository/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryCubit({required categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryInitial());

  getCategory() async {
    emit(CategoryLoading());
    final result = await _categoryRepository.getCategory();

    result.fold(
      (failure) {
        var errorState = CategoryError(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(CategoryLoaded(categoryList: value));
      },
    );
  }
}
