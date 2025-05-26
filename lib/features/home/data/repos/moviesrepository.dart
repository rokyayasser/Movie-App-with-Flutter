import 'dart:convert';
import 'package:movies_app/core/constants.dart';
import 'package:movies_app/features/home/data/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MoviesRepo {
  Future<List<movies>> fetchTopRatedMovies() async {
    final response =
        await http.get(Uri.parse('$baseurl/movie/top_rated?$apikey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> jsonmovies = data['results'];
      return jsonmovies.map((json) {
        return movies.fromJson({
          'overview': json['overview'],
          'poster_path': '${json['poster_path']}',
          'id': json['id'],
          'title': json['title'],
          'popularity': json['popularity'],
          'vote_average': json['vote_average']
        });
      }).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<movies>> fetchTrendingMovies() async {
    final response =
        await http.get(Uri.parse('$baseurl/trending/movie/day?$apikey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> jsontrendingmovies = data['results'];
      return jsontrendingmovies.map((json) {
        return movies.fromJson({
          'overview': json['overview'],
          'poster_path': '${json['poster_path']}',
          'id': json['id'],
          'title': json['title'],
          'popularity': json['popularity'],
          'vote_average': json['vote_average']
        });
      }).toList();
    } else {
      throw Exception('Failed to load top Trending movies');
    }
  }

  Future<List<movies>> fetchPopularMovies() async {
    final response =
        await http.get(Uri.parse('$baseurl/movie/popular?$apikey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> jsontrendingmovies = data['results'];
      return jsontrendingmovies.map((json) {
        return movies.fromJson({
          'overview': json['overview'],
          'poster_path': '${json['poster_path']}',
          'id': json['id'],
          'title': json['title'],
          'popularity': json['popularity'],
          'vote_average': json['vote_average']
        });
      }).toList();
    } else {
      throw Exception('Failed to load top Trending movies');
    }
  }

  Future<List<movies>> fetchUpnextMovies() async {
    final response =
        await http.get(Uri.parse('$baseurl/movie/upcoming?$apikey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> jsonmovies = data['results'];
      return jsonmovies.map((json) {
        return movies.fromJson({
          'overview': json['overview'],
          'poster_path': '${json['poster_path']}',
          'id': json['id'],
          'title': json['title'],
          'popularity': json['popularity'],
          'vote_average': json['vote_average']
        });
      }).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<cast>> fetchCastList(int movieId) async {
    final response =
        await http.get(Uri.parse('$baseurl/movie/$movieId/credits?$apikey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> jsonCast = data['cast'];
      return jsonCast
          .where((json) => json['known_for_department'] == 'Acting')
          .map((json) {
        return cast.fromJson({
          'id': json['id'],
          'original_name': json['original_name'],
          'profile_path': json['profile_path'],
          'known_for_department': json['known_for_department'],
        });
      }).toList();
    } else {
      throw Exception('Failed to load cast list');
    }
  }

  Future<List<movies>> searchMovies(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = '$baseurl/search/movie?$apikey&query=$encodedQuery';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        return results.map((json) {
          return movies.fromJson({
            'overview': json['overview'],
            'poster_path': '${json['poster_path']}',
            'id': json['id'],
            'title': json['title'],
            'popularity': json['popularity'],
            'vote_average': json['vote_average']
          });
        }).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
