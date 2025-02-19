part of 'top_rated_bloc.dart';

@immutable
sealed class TopRatedStateAbstract {}

///----Movies States
class TopRatedInitialState extends TopRatedStateAbstract {}

class TopRatedLoadingState extends TopRatedStateAbstract {}

class TopRatedSuccessState extends TopRatedStateAbstract {}

class TopRatedErrorState extends TopRatedStateAbstract {
  final String message;
  TopRatedErrorState({required this.message});
}

class TopRatedEmptyState extends TopRatedStateAbstract {}