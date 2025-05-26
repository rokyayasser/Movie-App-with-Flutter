import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/data/repos/moviesrepository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MoviesRepo _moviesRepo;
  SearchCubit(this._moviesRepo) : super(SearchInitial());
  Future<void> fetchSearchMovies(String query) async {
    emit(SearchLoading());
    try {
      final Searchmovies = await _moviesRepo.searchMovies(query);
      emit(SearchSuccess(Searchmovies));
    } catch (e) {
      emit(SearchFailure('An error occurred: ${e.toString()}'));
    }
  }
}
