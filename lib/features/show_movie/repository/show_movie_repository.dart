import 'package:dartz/dartz.dart';
import 'package:movie_app_task/core/apis/api_failure.dart';
import 'package:movie_app_task/core/apis/api_helper.dart';
import 'package:movie_app_task/core/apis/api_paths.dart';

class ShowMovieRepository {
  ///---------------------------///
  ///----Delete Movie Rating----///
  ///---------------------------///
  Future<Either<Failure, bool>> deleteMovieRating(int movieId) async {
    String url = ApiPaths.deleteMovieRating(movieId);

    Either<Failure, bool> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.delete,
      url: url,
      onSuccess: (response) {
        result = right(true);
      },
      onFailure: (e) {
        result = left(Failure(e.toString()));
      },
    );

    return result;
  }

  ///------------------///
  ///----Rate Movie----///
  ///------------------///
  Future<Either<Failure, bool>> rateMovie(int movieId, double rating) async {
    String url = ApiPaths.rateMovie(movieId);

    Either<Failure, bool> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.post,
      url: url,
      body: {
        "value": rating,
      },
      onSuccess: (response) {
        result = right(true);
      },
      onFailure: (e) {
        result = left(Failure(e.toString()));
      },
    );

    return result;
  }

  ///-----------------------///
  ///----Get User Rating----///
  ///-----------------------///
  Future<Either<Failure, double?>> getUserRating(int movieId) async {
    String url = ApiPaths.getUserRating(movieId);

    Either<Failure, double?> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.get,
      url: url,
      onSuccess: (response) {
        double? rating;

        final Map<String, dynamic> data =
            response.data; // No need for jsonDecode

        if (data.containsKey('rated') &&
            data['rated'] is Map<String, dynamic>) {
          rating = (data['rated']['value'] as num).toDouble();
        }

        result = right(rating);
      },
      onFailure: (e) {
        result = left(Failure(e.toString()));
      },
    );

    return result;
  }
}
