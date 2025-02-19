part of 'discover_bloc.dart';

@immutable
sealed class DiscoverEventAbstract {}

class MoviesStartProcessEvent extends DiscoverEventAbstract {}

class TvShowsStartProcessEvent extends DiscoverEventAbstract {}

class ToggleDiscoverTvEvent extends DiscoverEventAbstract {
  final bool isMovies;
  ToggleDiscoverTvEvent({required this.isMovies});
}

class SearchMoviesTvEvent extends DiscoverEventAbstract {
  final String searchQuery;
  SearchMoviesTvEvent({required this.searchQuery});
}
