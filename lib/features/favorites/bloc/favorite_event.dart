part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEventAbstract {}

class GetFavoriteEvent extends FavoriteEventAbstract {}

class ChangeFavoriteStatusEvent extends FavoriteEventAbstract {
  final int movieId;
  final bool isFavorite;

  ChangeFavoriteStatusEvent(this.movieId, this.isFavorite);
}

class CheckIfFavoriteEvent extends FavoriteEventAbstract {
  final int movieId;

  CheckIfFavoriteEvent(this.movieId);
}
