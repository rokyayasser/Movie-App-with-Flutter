import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/features/home/presentation/views/widgets/overviewscreen.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/movies_cubit.dart';

class PopularView extends StatefulWidget {
  const PopularView({super.key});

  @override
  State<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MoviesCubit>().fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesSuccess) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 5.0, // Horizontal spacing between items
              mainAxisSpacing: 5.0, // Vertical spacing between items
              childAspectRatio: 2 / 3, // Aspect ratio of each item
            ),
            itemCount: state.movieslist.length, // Number of items in the grid
            itemBuilder: (context, index) {
              final movie = state.movieslist[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OverViewScreen(movie: movie),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          '$baseimageurl${movie.poster_path}'), // Replace with movie poster URL
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.all(4.0),
                ),
              );
            },
          );
        } else if (state is MoviesFailure) {
          return Center(
            child: Text(
              state.errormessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else {
          return Container(color: Colors.red);
        }
      },
    );
  }
}
