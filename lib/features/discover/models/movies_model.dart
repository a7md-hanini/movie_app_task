import 'package:movie_app_task/core/apis/api_test_map.dart';

class MoviesModel {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int> genreIds;
  final bool adult;
  final bool video;

  MoviesModel({
    this.id = 0,
    this.title = '',
    this.originalTitle = '',
    this.overview = '',
    this.backdropPath = '',
    this.posterPath = '',
    this.releaseDate = '',
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.popularity = 0.0,
    this.genreIds = const [],
    this.adult = false,
    this.video = false,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: testMap(json, 'id', 0),
      title: testMap(json, 'title', ''),
      originalTitle: testMap(json, 'original_title', ''),
      overview: testMap(json, 'overview', ''),
      backdropPath: testMap(json, 'backdrop_path', ''),
      posterPath: testMap(json, 'poster_path', ''),
      releaseDate: testMap(json, 'release_date', ''),
      voteAverage: testMap(json, 'vote_average', 0.0),
      voteCount: testMap(json, 'vote_count', 0),
      popularity: testMap(json, 'popularity', 0.0),
      genreIds: List<int>.from(testMap(json, 'genre_ids', [])),
      adult: testMap(json, 'adult', false),
      video: testMap(json, 'video', false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genre_ids': genreIds,
      'adult': adult,
      'video': video,
    };
  }
}
