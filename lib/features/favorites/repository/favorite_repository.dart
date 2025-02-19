import 'package:dartz/dartz.dart';
import 'package:movie_app_task/core/apis/api_failure.dart';
import 'package:movie_app_task/core/apis/api_helper.dart';
import 'package:movie_app_task/core/apis/api_paths.dart';
import 'package:movie_app_task/features/discover/models/movies_model.dart';

class FavoriteRepository {
  ///------------------///
  ///----Get Movies----///
  ///------------------///
  Future<Either<Failure, List<MoviesModel>>> getFavorites() async {
    String url = ApiPaths.getFavoritesMovies;

    List<MoviesModel> favoritesMovies = [];
    Either<Failure, List<MoviesModel>> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.get,
      url: url,
      onSuccess: (response) {
        response.data['results'].forEach((element) {
          favoritesMovies.add(MoviesModel.fromJson(element));
        });
        result = right(favoritesMovies);
      },
      onFailure: (e) {
        result = left(Failure(e.toString()));
      },
    );

    return result;
  }

  ///-------------------------------///
  ///----Add Or Remove Favorites----///
  ///-------------------------------///
  Future<Either<Failure, bool>> addOrRemoveFavorites(
      int movieId, bool isFavorite) async {
    String url = ApiPaths.addOrRemoveToFavorite;

    Either<Failure, bool> result = left(Failure('Unknown error'));

    await ApiHelper.request(
      method: HttpMethod.post,
      url: url,
      body: {
        "media_type": "movie",
        "media_id": movieId,
        "favorite": isFavorite
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
}
