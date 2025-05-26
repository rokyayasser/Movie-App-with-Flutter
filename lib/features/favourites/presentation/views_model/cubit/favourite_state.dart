part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<FavItemModel> favouritelist;
  FavouriteLoaded(this.favouritelist);
}

class FavouriteFailure extends FavouriteState {
  final String errormessage;

  FavouriteFailure(this.errormessage);
}

class FavouriteAdded extends FavouriteState {
  final FavItemModel item;

  FavouriteAdded(this.item);
}

class FavouriteRemoved extends FavouriteState {
  final FavItemModel item;

  FavouriteRemoved(this.item);
}
