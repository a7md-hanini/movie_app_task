import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/features/discover/models/movies_model.dart';
import 'package:movie_app_task/features/top_rated/repository/top_rated_repository.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEventAbstract, TopRatedStateAbstract> {
  final TopRatedRepository repository;
  final BuildContext context;

  List<MoviesModel> moviesList = [];

  TopRatedBloc(this.context, {required this.repository})
      : super(TopRatedInitialState()) {
    on<TopRatedStartProcessEvent>(_onTopRatedStartProcessEvent);
  }

  ///-------------------///
  ///----Load Movies----///
  ///-------------------///
  Future<void> _onTopRatedStartProcessEvent(TopRatedStartProcessEvent event,
      Emitter<TopRatedStateAbstract> emit) async {
    emit(TopRatedLoadingState());
    final result = await repository.getMovies();

    result.fold(
      (failure) {
        log('Movies Failure: ${failure.message}');
        emit(TopRatedErrorState(message: failure.message));
      },
      (success) {
        log('Movies Success');
        if (success.isEmpty) {
          emit(TopRatedEmptyState());
        } else {
          moviesList = success;
          emit(TopRatedSuccessState());
        }
      },
    );
  }
}
