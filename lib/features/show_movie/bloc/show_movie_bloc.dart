import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/features/show_movie/bloc/show_movie_state.dart';
import 'package:movie_app_task/features/show_movie/repository/show_movie_repository.dart';

part 'show_movie_event.dart';

class ShowMovieBloc
    extends Bloc<ShowMovieEventAbstract, ShowMovieStateAbstract> {
  final ShowMovieRepository repository;

  ShowMovieBloc({required this.repository}) : super(ShowMovieInitialState()) {
    on<DeleteMovieRatingEvent>(_onDeleteMovieRating);
    on<AddMovieRatingEvent>(_onAddMovieRating);
    on<GetUserRatingEvent>(_onGetUserRating);
  }

  ///----Delete Movie Rating----///

  Future<void> _onDeleteMovieRating(
    DeleteMovieRatingEvent event,
    Emitter<ShowMovieStateAbstract> emit,
  ) async {
    emit(DeleteMovieRatingLoadingState());

    final result = await repository.deleteMovieRating(event.movieId);

    result.fold(
      (failure) {
        emit(DeleteMovieRatingErrorState(message: failure.message));
      },
      (success) {
        emit(DeleteMovieRatingSuccessState());
        emit(GetUserRatingSuccessState(null)); // Reset rating
      },
    );
  }

  ///----Add Movie Rating----///
  FutureOr<void> _onAddMovieRating(
    AddMovieRatingEvent event,
    Emitter<ShowMovieStateAbstract> emit,
  ) async {
    emit(AddMovieRatingLoadingState());

    final result = await repository.rateMovie(event.movieId, event.rating);

    result.fold(
      (failure) {
        log('Rating Failure: ${failure.message}');
        emit(AddMovieRatingErrorState(message: failure.message));
      },
      (success) {
        emit(AddMovieRatingSuccessState());
        emit(GetUserRatingSuccessState(event.rating));
      },
    );
  }

  ///----Get User Rating----///
  FutureOr<void> _onGetUserRating(
    GetUserRatingEvent event,
    Emitter<ShowMovieStateAbstract> emit,
  ) async {
    emit(GetUserRatingLoadingState());

    final result = await repository.getUserRating(event.movieId);

    result.fold(
      (failure) {
        log('User Rating Error: ${failure.message}');
        emit(GetUserRatingErrorState(message: failure.message));
      },
      (rating) {
        emit(GetUserRatingSuccessState(rating));
      },
    );
  }
}
