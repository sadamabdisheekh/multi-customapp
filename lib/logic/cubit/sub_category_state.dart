part of 'sub_category_cubit.dart';

sealed class SubCategoryState extends Equatable {
  const SubCategoryState();

  @override
  List<Object> get props => [];
}

final class SubCategoryInitial extends SubCategoryState {}

final class SubCategoryLoading extends SubCategoryState {}

final class SubCategoryError extends SubCategoryState {
  final CustomError error;
  const SubCategoryError({required this.error});
}

final class SubCategoryLoaded extends SubCategoryState {
  final List<SubCategoryModel> subCategoryList;
  const SubCategoryLoaded({required this.subCategoryList});
}
