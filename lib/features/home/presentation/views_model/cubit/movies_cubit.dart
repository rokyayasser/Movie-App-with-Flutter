import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/data/repos/moviesrepository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepo _moviesRepo;
  MoviesCubit(this._moviesRepo) : super(MoviesInitial());
  Future<void> fetchMovies() async {
    emit(MoviesLoading());
    try {
      final movies = await _moviesRepo.fetchTopRatedMovies();
      emit(MoviesSuccess(movieslist: movies));
    } catch (e) {
      emit(MoviesFailure(errormessage: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> fetchUpnextMovies() async {
    emit(MoviesLoading());
    try {
      final movies = await _moviesRepo.fetchUpnextMovies();
      emit(MoviesSuccess(movieslist: movies));
    } catch (e) {
      emit(MoviesFailure(errormessage: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> fetchTrendingMovies() async {
    emit(MoviesLoading());
    try {
      final Trendingmovies = await _moviesRepo.fetchTrendingMovies();
      emit(MoviesSuccess(movieslist: Trendingmovies));
    } catch (e) {
      emit(MoviesFailure(errormessage: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> fetchPopularMovies() async {
    emit(MoviesLoading());
    try {
      final Popularmovies = await _moviesRepo.fetchPopularMovies();
      emit(MoviesSuccess(movieslist: Popularmovies));
    } catch (e) {
      emit(MoviesFailure(errormessage: 'An error occurred: ${e.toString()}'));
    }
  }
}
