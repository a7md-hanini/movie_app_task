import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:movie_app_task/features/favorites/bloc/favorite_bloc.dart';
import 'package:movie_app_task/features/show_movie/bloc/show_movie_bloc.dart';
import 'package:movie_app_task/features/show_movie/bloc/show_movie_state.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoriteRateContainer extends StatelessWidget {
  final int movieId;

  const FavoriteRateContainer({
    required this.movieId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteBloc>().add(CheckIfFavoriteEvent(movieId));
    context.read<ShowMovieBloc>().add(GetUserRatingEvent(movieId));
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black38,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<FavoriteBloc, FavoritesStateAbstract>(
                builder: (context, state) {
                  //----Watch Rebuild
                  var bloc = context.watch<FavoriteBloc>();
                  return IconButton(
                    padding: const EdgeInsets.all(10),
                    onPressed: () {
                      bloc.add(
                          ChangeFavoriteStatusEvent(movieId, !bloc.isFavorite));
                    },
                    icon: Icon(
                      bloc.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: bloc.isFavorite ? Colors.red : Colors.grey,
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              BlocBuilder<ShowMovieBloc, ShowMovieStateAbstract>(
                builder: (context, state) {
                  var bloc = context.watch<ShowMovieBloc>();

                  double initialRating = 0.0;
                  bool hasUserRated = false;

                  if (state is GetUserRatingSuccessState) {
                    initialRating = state.rating ?? 0.0;
                    hasUserRated = state.hasUserRated;
                  }

                  return Row(
                    children: [
                      ///----Rate Button----///
                      RatingBar.builder(
                        initialRating: initialRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        unratedColor: Colors.amber.withAlpha(50),
                        itemSize: 20,
                        itemCount: 10,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          bloc.add(AddMovieRatingEvent(movieId, rating));
                        },
                      ),
                      const SizedBox(width: 10),

                      ///----Delete Rating Button----///
                      if (hasUserRated)
                        InkWell(
                          onTap: () {
                            bloc.add(DeleteMovieRatingEvent(movieId));
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.delete, color: Colors.redAccent),
                              MyText(text: 'Remove', color: Colors.redAccent),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
