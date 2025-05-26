import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants.dart';
import 'dart:ui';
import 'package:movies_app/core/widgets/apptext_button.dart';
import 'package:movies_app/core/widgets/favicon_button.dart';
import 'package:movies_app/core/widgets/ratingindicator_bar.dart';
import 'package:movies_app/core/widgets/showtoast.dart';
import 'package:movies_app/features/favourites/data/models/fav_model.dart';
import 'package:movies_app/features/favourites/presentation/views_model/cubit/favourite_cubit.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/data/repos/moviesrepository.dart';
import 'package:movies_app/features/home/presentation/views/widgets/castlist_view.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/cast_cubit.dart';
import 'package:movies_app/features/movie/presentation/views/movievedio_screen.dart';

class OverViewScreen extends StatelessWidget {
  const OverViewScreen({
    super.key,
    required this.movie,
  });

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
        return Scaffold(
          body: BlocProvider(
            create: (context) => CastCubit(MoviesRepo())..fetchCast(movie.id),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('$baseimageurl${movie.poster_path}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.5),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingIndicator(rating: movie.vote_average),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                movie.vote_average.toStringAsFixed(1),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            movie.overview,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 110, // Adjusted height to accommodate the text
                        child: BlocBuilder<CastCubit, CastState>(
                          builder: (context, state) {
                            if (state is CastLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CastFailure) {
                              return Center(
                                child: Text(
                                  state.errormessage,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            } else if (state is CastSuccess) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.castlist.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final castlist = state.castlist[index];
                                  return CastView(castlist: castlist);
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(18)),
                          child: FavoriteIconButton(
                            favItem: favItem,
                            size: 40,
                            iconcolor: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10), // Space between widgets
                        Expanded(
                          child: AppTextButton(
                            buttonHeight: 5,
                            shadowColor: const Color(0xffF83758),
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
                                  ));
                            },
                            backgroundColor: const Color(0xffF83758),
                            borderColor: Colors.transparent,
                            borderRadius: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
