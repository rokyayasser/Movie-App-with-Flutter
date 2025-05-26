import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/features/favourites/data/models/fav_model.dart';
import 'package:movies_app/features/favourites/data/repos/favouriterepo_.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepository repository;

  FavouriteCubit(this.repository) : super(FavouriteInitial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final favourites = await repository.getFavorites();
      print('Loaded favorites: $favourites'); // For debugging purposes
      emit(FavouriteLoaded(_sortNotes(favourites)));
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }

  Future<void> addFavorite(FavItemModel item) async {
    try {
      await repository.addFavorite(item);
      emit(FavouriteAdded(item));
      loadFavorites();
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }

  Future<void> removeFavorite(FavItemModel item) async {
    try {
      await repository.removeFavorite(item);
      emit(FavouriteRemoved(item));
      loadFavorites();
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }

  bool isFavorite(FavItemModel item) {
    if (state is FavouriteLoaded) {
      return (state as FavouriteLoaded)
          .favouritelist
          .any((favourite) => favourite.Title == item.Title);
    }
    return false;
  }

  List<FavItemModel> _sortNotes(List<FavItemModel> movie) {
    movie.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return movie;
  }
}
