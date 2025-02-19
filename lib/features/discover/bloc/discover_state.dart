part of 'discover_bloc.dart';

@immutable
sealed class DiscoverStateAbstract {}

///----Movies States
class MoviesInitialState extends DiscoverStateAbstract {}

class MoviesLoadingState extends DiscoverStateAbstract {}

class MoviesSuccessState extends DiscoverStateAbstract {}

class MoviesErrorState extends DiscoverStateAbstract {
  final String message;
  MoviesErrorState({required this.message});
}

class MoviesEmptyState extends DiscoverStateAbstract {}

///----TV Shows States
class TvShowsLoadingState extends DiscoverStateAbstract {}

class TvShowsSuccessState extends DiscoverStateAbstract {}

class TvShowsErrorState extends DiscoverStateAbstract {
  final String message;
  TvShowsErrorState({required this.message});
}

class TvShowsEmptyState extends DiscoverStateAbstract {}

///----Toggle State
class ToggleMoviesTvState extends DiscoverStateAbstract {}

class SearchMoviesState extends DiscoverStateAbstract {}

class SearchTvState extends DiscoverStateAbstract {}
