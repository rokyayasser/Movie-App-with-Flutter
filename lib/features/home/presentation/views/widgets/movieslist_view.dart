import 'package:flutter/material.dart';
import 'package:movies_app/core/widgets/gradientdivider.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/presentation/views/widgets/movie_item.dart';

class MoviesListBody extends StatelessWidget {
  final List<movies> moviesList;

  const MoviesListBody({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: moviesList.length,
      itemBuilder: (context, index) {
        final movies = moviesList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              MovieItem(
                movie: movies,
              ),
              const SizedBox(
                height: 10,
              ),
              index == moviesList.length - 1
                  ? const SizedBox()
                  : const GradientDivider(
                      height: 1.0,
                      indent: 10,
                      endIndent: 10,
                      colors: [
                        Color(0xFF000000),
                        Color(0xFFCECECE),
                        Color(0xFF000000)
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
