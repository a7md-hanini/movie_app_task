import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/features/discover/models/movies_model.dart';
import 'package:movie_app_task/features/favorites/repository/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEventAbstract, FavoritesStateAbstract> {
  final FavoriteRepository repository;

  List<MoviesModel> favoritesList = [];
  bool isFavorite = false;

  FavoriteBloc({required this.repository}) : super(FavoritesInitialState()) {
    on<GetFavoriteEvent>(_onLoadFavorites);
    on<ChangeFavoriteStatusEvent>(_onChangeFavoriteStatus);
    on<CheckIfFavoriteEvent>(_onCheckIfFavorite);
  }

  ///----------------------///
  ///----Load Favorites----///
  ///----------------------///
  Future<void> _onLoadFavorites(
      GetFavoriteEvent event, Emitter<FavoritesStateAbstract> emit) async {
    emit(GetFavoritesLoadingState());
    final result = await repository.getFavorites();

    result.fold(
      (failure) {
        log('Favorites Failure: ${failure.message}');
        emit(GetFavoritesErrorState(message: failure.message));
      },
      (success) {
        if (success.isEmpty) {
          emit(GetFavoritesEmptyState());
        } else {
          favoritesList = success;
          emit(GetFavoritesSuccessState());
        }
      },
    );
  }

  FutureOr<void> _onChangeFavoriteStatus(
    ChangeFavoriteStatusEvent event,
    Emitter<FavoritesStateAbstract> emit,
  ) async {
    emit(ChangeFavoriteStatusLoadingState());

    final result =
        await repository.addOrRemoveFavorites(event.movieId, event.isFavorite);

    result.fold(
      (failure) {
        log('Favorites Failure: ${failure.message}');
        emit(ChangeFavoriteStatusErrorState(message: failure.message));
      },
      (success) {
        if (event.isFavorite) {
          favoritesList.add(MoviesModel(id: event.movieId));
        } else {
          favoritesList.removeWhere((movie) => movie.id == event.movieId);
        }

        isFavorite =
            favoritesList.any((element) => element.id == event.movieId);

        emit(ChangeFavoriteStatusSuccessState());
      },
    );
  }

  FutureOr<void> _onCheckIfFavorite(
      CheckIfFavoriteEvent event, Emitter<FavoritesStateAbstract> emit) {
    isFavorite = favoritesList.any((element) => element.id == event.movieId);
    emit(CheckIfFavoriteState());
  }
}
