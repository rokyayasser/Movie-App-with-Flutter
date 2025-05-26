part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchFailure extends SearchState {
  final String errormessage;
  SearchFailure(this.errormessage);
}

final class SearchSuccess extends SearchState {
  final List<movies> searchlist;
  SearchSuccess(this.searchlist);
}
