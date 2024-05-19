import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/data/providers/error/custom_error.dart';
import '../../data/models/sub_category.dart';
import '../../data/repository/category_repository.dart';

part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
   final CategoryRepository _categoryRepository;
  SubCategoryCubit({required categoryRepository}) :_categoryRepository = categoryRepository, super(SubCategoryInitial());

  getSubCategory(int categoryId) async {
    emit(SubCategoryLoading());
    final result = await _categoryRepository.getSubCategory(categoryId);
    
    result.fold(
      (failure) {
        var errorState = SubCategoryError(
            error: CustomError(
                statusCode: failure.statusCode, message: failure.message));
        emit(errorState);
      },
      (value) {
        emit(SubCategoryLoaded(subCategoryList: value));
      },
    );
  }

}
