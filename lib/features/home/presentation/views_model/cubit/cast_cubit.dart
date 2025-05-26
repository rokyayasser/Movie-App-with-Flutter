import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:movies_app/features/home/data/repos/moviesrepository.dart';

part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  final MoviesRepo _moviesRepo;
  CastCubit(this._moviesRepo) : super(CastInitial());
  Future<void> fetchCast(int movieid) async {
    emit(CastLoading());
    try {
      final cast = await _moviesRepo.fetchCastList(movieid);

      emit(CastSuccess(castlist: cast));
    } catch (e) {
      emit(CastFailure(errormessage: 'An error occurred: ${e.toString()}'));
    }
  }
}
