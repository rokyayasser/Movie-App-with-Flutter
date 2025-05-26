import 'package:hive/hive.dart';
part 'fav_model.g.dart';

@HiveType(typeId: 0)
class FavItemModel extends HiveObject {
  @HiveField(0)
  final String ImageUrl;
  @HiveField(1)
  final String Title;
  @HiveField(2)
  final DateTime timestamp;
  FavItemModel(
      {required this.ImageUrl, required this.Title, required this.timestamp});
  @override
  String toString() {
    return 'FavItemModel(Title: $Title, ImageUrl: $ImageUrl, timestamp: $timestamp  )';
  }
}
