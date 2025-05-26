part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesFailure extends MoviesState {
  final String errormessage;
  MoviesFailure({required this.errormessage});
}

final class MoviesSuccess extends MoviesState {
  final List<movies> movieslist;
  MoviesSuccess({required this.movieslist});
}
