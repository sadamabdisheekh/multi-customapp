part of 'category_cubit.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryError extends CategoryState {
  final CustomError error;
  const CategoryError({required this.error});
}


final class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categoryList;
  const CategoryLoaded({required this.categoryList});
}
