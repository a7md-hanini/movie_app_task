import 'package:movie_app_task/core/apis/api_test_map.dart';

class TvModel {
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final String firstAirDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int> genreIds;
  final bool adult;
  final List<String> originCountry;

  TvModel({
    this.id = 0,
    this.name = '',
    this.originalName = '',
    this.overview = '',
    this.backdropPath = '',
    this.posterPath = '',
    this.firstAirDate = '',
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.popularity = 0.0,
    this.genreIds = const [],
    this.adult = false,
    this.originCountry = const [],
  });

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
      id: testMap(json, 'id', 0),
      name: testMap(json, 'name', ''),
      originalName: testMap(json, 'original_name', ''),
      overview: testMap(json, 'overview', ''),
      backdropPath: testMap(json, 'backdrop_path', ''),
      posterPath: testMap(json, 'poster_path', ''),
      firstAirDate: testMap(json, 'first_air_date', ''),
      voteAverage: testMap(json, 'vote_average', 0.0),
      voteCount: testMap(json, 'vote_count', 0),
      popularity: testMap(json, 'popularity', 0.0),
      genreIds: List<int>.from(testMap(json, 'genre_ids', [])),
      adult: testMap(json, 'adult', false),
      originCountry: List<String>.from(testMap(json, 'origin_country', [])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'original_name': originalName,
      'overview': overview,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'first_air_date': firstAirDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genre_ids': genreIds,
      'adult': adult,
      'origin_country': originCountry,
    };
  }
}
