part of 'item_details_cubit.dart';

class ItemDetailsState extends Equatable {
  const ItemDetailsState();

  @override
  List<Object> get props => [];
}

final class ItemDetailsInitial extends ItemDetailsState {}

class ItemDetailsLoadingState extends ItemDetailsState {}

class ItemDetailsErrorState extends ItemDetailsState {
  final CustomError error;

  const ItemDetailsErrorState({required this.error});
}

class ItemDetailsLoadedState extends ItemDetailsState {
  final ItemDetailsModel itemDetails;

  const ItemDetailsLoadedState({required this.itemDetails});
}
