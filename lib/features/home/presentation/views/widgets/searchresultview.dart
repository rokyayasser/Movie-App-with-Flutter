import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/presentation/views/widgets/movie_item.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/movies_cubit.dart';
import 'package:movies_app/features/home/presentation/views_model/cubit/search_cubit.dart';

class SearchResultsView extends StatelessWidget {
  final String query;

  const SearchResultsView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Please enter a search term'));
    }

    context.read<SearchCubit>().fetchSearchMovies(query);

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchSuccess) {
          if (state.searchlist.isEmpty) {
            return const Center(
                child: Text(
              'No results found',
              style: TextStyle(color: Colors.white),
            ));
          }
          return ListView.builder(
            itemCount: state.searchlist.length,
            itemBuilder: (context, index) {
              final movie = state.searchlist[index];
              return Column(
                children: [
                  MovieItem(
                    search: true,
                    movie: movie,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              );
            },
          );
        } else if (state is SearchFailure) {
          return Center(child: Text(state.errormessage));
        }
        return Container();
      },
    );
  }
}
