import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/presentation/views/widgets/movieslist_view.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/movies_cubit.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({super.key});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MoviesCubit>().fetchTrendingMovies();
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
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: MoviesListBody(moviesList: state.movieslist),
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
