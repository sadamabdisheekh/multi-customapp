part of 'items_cubit.dart';

class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

final class ItemsInitial extends ItemsState {}

final class ItemsLoading extends ItemsState {}

final class ItemsError extends ItemsState {
  final CustomError error;
  const ItemsError({required this.error});
}

final class ItemsLoaded extends ItemsState {
  final List<StoreItemsModel> itemsList;
  const ItemsLoaded({required this.itemsList});
}
