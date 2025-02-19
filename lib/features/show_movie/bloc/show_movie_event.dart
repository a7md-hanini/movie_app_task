part of 'show_movie_bloc.dart';

@immutable
sealed class ShowMovieEventAbstract {}

class DeleteMovieRatingEvent extends ShowMovieEventAbstract {
  final int movieId;
  DeleteMovieRatingEvent(this.movieId);
}

class AddMovieRatingEvent extends ShowMovieEventAbstract {
  final int movieId;
  final double rating;

  AddMovieRatingEvent(this.movieId, this.rating);
}

class GetUserRatingEvent extends ShowMovieEventAbstract {
  final int movieId;

  GetUserRatingEvent(this.movieId);
}
