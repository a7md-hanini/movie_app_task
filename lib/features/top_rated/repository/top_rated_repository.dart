import 'package:dartz/dartz.dart';
import 'package:movie_app_task/core/apis/api_failure.dart';
import 'package:movie_app_task/core/apis/api_helper.dart';
import 'package:movie_app_task/core/apis/api_paths.dart';
import 'package:movie_app_task/features/discover/models/movies_model.dart';

class TopRatedRepository {
  ///------------------///
  ///----Get Movies----///
  ///------------------///
  Future<Either<Failure, List<MoviesModel>>> getMovies() async {
    String url = ApiPaths.topRatedMoviesApi;

    List<MoviesModel> movies = [];
    Either<Failure, List<MoviesModel>> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.get,
      url: url,
      onSuccess: (response) {
        response.data['results'].forEach((element) {
          movies.add(MoviesModel.fromJson(element));
        });
        result = right(movies);
      },
      onFailure: (e) {
        result = left(Failure(e.toString()));
      },
    );

    return result;
  }
}
