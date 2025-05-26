import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/constants.dart';

part 'vediofilm_state.dart';

class VediofilmCubit extends Cubit<VediofilmState> {
  VediofilmCubit() : super(VediofilmInitial());

  Future<void> fetchVideoKeys(int movieid) async {
    emit(VediofilmLoading());

    try {
      final response =
          await http.get(Uri.parse('$baseurl/movie/$movieid/videos?$apikey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        if (results.isNotEmpty) {
          final videoKey = results[0]['key']; // Extract the first video key
          emit(VediofilmSuccess(videoKey));
        } else {
          emit(VediofilmFailure('No videos found for this movie'));
        }
      } else {
        emit(VediofilmFailure('Failed to load video: ${response.statusCode}'));
      }
    } catch (e) {
      emit(VediofilmFailure('An error occurred: $e'));
    }
  }
}
