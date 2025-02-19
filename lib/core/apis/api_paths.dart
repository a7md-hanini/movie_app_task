class ApiPaths {
  static const moviesApi =
      'discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc';
  static const tvApi =
      'discover/tv?include_adult=false&include_null_first_air_dates=false&language=en-US&page=1&sort_by=popularity.desc';
  static const topRatedMoviesApi = 'movie/top_rated?language=en-US&page=1';
static const String getFavoritesMovies='account/21821685/favorite/movies?language=en-US&page=1&sort_by=created_at.asc';
  static const String addOrRemoveToFavorite= 'account/21821685/favorite';
  static String deleteMovieRating(int movieId) => 'movie/$movieId/rating'; 
  static String rateMovie(int movieId) => 'movie/$movieId/rating';
  static String getUserRating(int movieId) => 'movie/$movieId/account_states';
}
