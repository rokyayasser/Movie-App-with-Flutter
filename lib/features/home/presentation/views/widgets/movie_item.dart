import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/widgets/apptext_button.dart';
import 'package:movies_app/core/widgets/favicon_button.dart';
import 'package:movies_app/core/widgets/ratingindicator_bar.dart';
import 'package:movies_app/core/widgets/showtoast.dart';
import 'package:movies_app/features/favourites/data/models/fav_model.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/presentation/views/widgets/overviewscreen.dart';
import 'package:movies_app/features/movie/presentation/views/movievedio_screen.dart';
import '../../../../favourites/presentation/views_model/cubit/favourite_cubit.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    this.search = false,
    required this.movie,
  });

  final bool search;
  final movies movie;
  @override
  Widget build(BuildContext context) {
    final favItem = FavItemModel(
      Title: movie.title,
      ImageUrl: '$baseimageurl${movie.poster_path}',
      timestamp: DateTime.now(), // Ensure you provide all required fields
    );
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteAdded) {
          if (state.item == favItem) {
            showToast(message: '${favItem.Title} added successfully');
          }
        } else if (state is FavouriteRemoved) {
          if (state.item == favItem) {
            showToast(message: '${favItem.Title} removed successfully');
          }
        }
      },
      builder: (context, state) {
        return MovieItem_Body(search: search, movie: movie, favItem: favItem);
      },
    );
  }
}

class MovieItem_Body extends StatelessWidget {
  const MovieItem_Body({
    super.key,
    required this.search,
    required this.movie,
    required this.favItem,
  });

  final bool search;
  final movies movie;
  final FavItemModel favItem;

  @override
  Widget build(BuildContext context) {
    return search
        ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OverViewScreen(movie: movie),
                  ));
            },
            child: Container(
              padding: search
                  ? const EdgeInsets.only(
                      right: 10, left: 10, bottom: 10, top: 10)
                  : EdgeInsets.zero,
              width: double.infinity,
              decoration: BoxDecoration(
                border: search
                    ? Border.all(color: Colors.grey.withOpacity(0.2), width: 1)
                    : const Border(),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image:
                            NetworkImage('$baseimageurl${movie.poster_path}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 122,
                    width: 89,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            RatingIndicator(rating: movie.vote_average),
                            const SizedBox(width: 8),
                            Text(
                              movie.vote_average.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        search
                            ? const SizedBox()
                            : AppTextButton(
                                buttonHeight: 5,
                                shadowColor: const Color(0xffF83758),
                                buttonWidth: 140,
                                buttonText: 'Watch Now',
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieVedioScreen(
                                        movie: movie,
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: const Color(0xffF83758),
                                borderColor: Colors.transparent,
                                borderRadius: 25,
                              ),
                      ],
                    ),
                  ),
                  search
                      ? const SizedBox()
                      : FavoriteIconButton(favItem: favItem),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OverViewScreen(
                            movie: movie,
                          ),
                        ),
                      );
                    },
                    child: search
                        ? const SizedBox()
                        : const Text(
                            'Overview',
                            style: TextStyle(
                              color: Color(0xff2662FD),
                              decorationColor: Color(0xff2662FD),
                              decorationThickness: 1.5,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: search
                ? const EdgeInsets.only(
                    right: 10, left: 10, bottom: 10, top: 10)
                : EdgeInsets.zero,
            width: double.infinity,
            decoration: BoxDecoration(
              border: search
                  ? Border.all(color: Colors.grey.withOpacity(0.2), width: 1)
                  : const Border(),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage('$baseimageurl${movie.poster_path}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 122,
                  width: 89,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          RatingIndicator(rating: movie.vote_average),
                          const SizedBox(width: 8),
                          Text(
                            movie.vote_average.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      search
                          ? const SizedBox()
                          : AppTextButton(
                              buttonHeight: 5,
                              shadowColor: const Color(0xffF83758),
                              buttonWidth: 140,
                              buttonText: 'Watch Now',
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieVedioScreen(
                                      movie: movie,
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: const Color(0xffF83758),
                              borderColor: Colors.transparent,
                              borderRadius: 25,
                            ),
                    ],
                  ),
                ),
                search
                    ? const SizedBox()
                    : FavoriteIconButton(favItem: favItem),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OverViewScreen(
                          movie: movie,
                        ),
                      ),
                    );
                  },
                  child: search
                      ? const SizedBox()
                      : const Text(
                          'Overview',
                          style: TextStyle(
                            color: Color(0xff2662FD),
                            decorationColor: Color(0xff2662FD),
                            decorationThickness: 1.5,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                ),
              ],
            ),
          );
  }
}
