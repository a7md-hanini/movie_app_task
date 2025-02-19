part of 'favorite_bloc.dart';

@immutable
sealed class FavoritesStateAbstract {}

///----Favorites States
class FavoritesInitialState extends FavoritesStateAbstract {}

class GetFavoritesLoadingState extends FavoritesStateAbstract {}

class GetFavoritesSuccessState extends FavoritesStateAbstract {}

class GetFavoritesErrorState extends FavoritesStateAbstract {
  final String message;
  GetFavoritesErrorState({required this.message});
}

class GetFavoritesEmptyState extends FavoritesStateAbstract {}

class ChangeFavoriteStatusLoadingState extends FavoritesStateAbstract {}

class ChangeFavoriteStatusSuccessState extends FavoritesStateAbstract {}

class ChangeFavoriteStatusErrorState extends FavoritesStateAbstract {
  final String message;
  ChangeFavoriteStatusErrorState({required this.message});
}

class CheckIfFavoriteState extends FavoritesStateAbstract {}
