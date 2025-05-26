import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/core/widgets/ratingindicator_bar.dart';
import 'package:movies_app/features/home/data/repos/moviesrepository.dart';
import 'package:movies_app/features/home/presentation/views/widgets/castlist_view.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/cast_cubit.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/movies_cubit.dart';
import 'package:movies_app/features/movie/presentation/views/widgets/upnext_view.dart';
import 'package:movies_app/features/movie/presentation/views_model/cubit/vediofilm_cubit.dart';

class MovieVedioScreen extends StatelessWidget {
  const MovieVedioScreen({
    super.key,
    required this.movie,
  });

  final movies movie;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        backgroundColor: constbackground,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CastCubit(MoviesRepo())..fetchCast(movie.id),
            ),
            BlocProvider(
              create: (context) =>
                  MoviesCubit(MoviesRepo())..fetchUpnextMovies(),
            ),
            BlocProvider(
              create: (context) => VediofilmCubit()..fetchVideoKeys(movie.id),
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<VediofilmCubit, VediofilmState>(
                  builder: (context, state) {
                    if (state is VediofilmLoading) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        color: Colors.black,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is VediofilmSuccess) {
                      return YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: state.vediokey,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            mute: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        color: Colors.black,
                        child: const Center(
                          child: Text('Failed to load video',
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
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
                        children: [
                          RatingIndicator(rating: movie.vote_average),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            movie.vote_average.toStringAsFixed(1),
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
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
                      const SizedBox(height: 25),
                      const Text(
                        'Cast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 110,
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
                                itemCount: 5,
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
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'UP Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 200,
                        child: BlocBuilder<MoviesCubit, MoviesState>(
                          builder: (context, state) {
                            if (state is MoviesLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is MoviesFailure) {
                              return Center(
                                child: Text(
                                  state.errormessage,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            } else if (state is MoviesSuccess) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.movieslist.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final upnextlist = state.movieslist[index];
                                  return UpNextView(
                                    upnextlist: upnextlist,
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
