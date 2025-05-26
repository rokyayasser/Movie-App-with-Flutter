class movies {
  final String title;
  final String overview;
  final String poster_path;
  final double popularity;
  final int id;
  final double vote_average;
  movies(
      {required this.vote_average,
      required this.title,
      required this.popularity,
      required this.overview,
      required this.id,
      required this.poster_path});
  factory movies.fromJson(Map<String, dynamic> json) {
    return movies(
        vote_average: (json['vote_average'] ?? 0.0).toDouble(),
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        overview: json['overview'] ?? '',
        popularity: (json['popularity'] ?? 0.0).toDouble(),
        poster_path: json['poster_path'] ?? '');
  }
}

class cast {
  final String original_name;
  final String profile_path;
  final String known_for_department;
  final int id;
  cast(
      {required this.id,
      required this.original_name,
      required this.profile_path,
      required this.known_for_department});
  factory cast.fromJson(Map<String, dynamic> json) {
    return cast(
        id: json['id'] ?? 0,
        original_name: json['original_name'] ?? '',
        profile_path: json['profile_path'] ?? '',
        known_for_department: json['known_for_department'] ?? '');
  }
}
