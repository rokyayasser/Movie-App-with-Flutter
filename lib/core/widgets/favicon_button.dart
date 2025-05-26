import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/favourites/data/models/fav_model.dart';
import 'package:movies_app/features/favourites/presentation/views_model/cubit/favourite_cubit.dart';

class FavoriteIconButton extends StatelessWidget {
  final FavItemModel favItem;
  final double? size;
  final Color? iconcolor;
  const FavoriteIconButton(
      {super.key, required this.favItem, this.size, this.iconcolor});

  @override
  Widget build(BuildContext context) {
    final favouriteCubit = context.read<FavouriteCubit>();
    final isFavourite = favouriteCubit.isFavorite(favItem);

    return IconButton(
      icon: Icon(
        isFavourite ? Icons.bookmark : Icons.bookmark_border,
        color: isFavourite ? Colors.amber : iconcolor,
        size: size ?? 28,
      ),
      onPressed: () {
        if (isFavourite) {
          favouriteCubit.removeFavorite(favItem);
        } else {
          favouriteCubit.addFavorite(favItem);
        }
      },
    );
  }
}
