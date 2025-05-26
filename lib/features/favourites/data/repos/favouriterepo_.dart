import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/features/favourites/data/models/fav_model.dart';

class FavouriteRepository {
  final String _boxName = favbox;
  late Box<FavItemModel> box;

  FavouriteRepository() {
    _initBox();
  }

  Future<void> _initBox() async {
    box = await Hive.openBox<FavItemModel>(_boxName);
  }

  Future<void> addFavorite(FavItemModel item) async {
    var box = await Hive.openBox<FavItemModel>(_boxName);
    await box.put(item.Title, item);
  }

  Future<void> removeFavorite(FavItemModel item) async {
    var box = await Hive.openBox<FavItemModel>(_boxName);
    await box.delete(item.Title);
  }

  Future<List<FavItemModel>> getFavorites() async {
    var box = await Hive.openBox<FavItemModel>(_boxName);
    final favorites = box.values.toList();
    print("Loaded favorites: $favorites"); // Debug print
    return favorites;
  }
}
