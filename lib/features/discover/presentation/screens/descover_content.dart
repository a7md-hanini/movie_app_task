import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/features/discover/bloc/discover_bloc.dart';
import 'package:movie_app_task/features/show_movie/presentation/screens/show_movie_screen.dart';
import 'package:movie_app_task/features/discover/presentation/widgets/movie_tv_item.dart';
import 'package:movie_app_task/features/discover/presentation/widgets/search_text_field.dart';

class DiscoverContent extends StatelessWidget {
  const DiscoverContent({super.key});

  @override
  Widget build(BuildContext context) {
    DiscoverBloc bloc = context.read<DiscoverBloc>();
    DiscoverBloc blocListener = context.watch<DiscoverBloc>();
    //bloc.state is MoviesLoadingState ? const SizedBox():

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----Search Text Field
            SearchTextField(
              hintText: 'Search...',
              searchController: bloc.searchController,
              onChanged: (newVal) {
                bloc.add(SearchMoviesTvEvent(searchQuery: newVal));
              },
            ),

            ///----Toggle Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton('Movies', blocListener.isMoviesSelected,
                      () => bloc.add(ToggleDiscoverTvEvent(isMovies: true))),
                  const VerticalDivider(
                      width: 20, thickness: 2, color: Colors.white),
                  _buildToggleButton('TV Shows', !blocListener.isMoviesSelected,
                      () => bloc.add(ToggleDiscoverTvEvent(isMovies: false))),
                ],
              ),
            ),

            ///----Movie TV Show List
            Expanded(
              child: BlocBuilder<DiscoverBloc, DiscoverStateAbstract>(
                builder: (context, state) {
                  ///----Loading
                  if (state is MoviesLoadingState ||
                      state is TvShowsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  ///----Error
                  if (state is MoviesErrorState || state is TvShowsErrorState) {
                    return Center(
                      child: Text(
                        'Error: ${state.toString()}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  ///----Movies Success
                  if (state is MoviesSuccessState ||
                      state is SearchMoviesState) {
                    return ListView.builder(
                      itemCount: bloc.filteredMoviesList.length,
                      itemBuilder: (context, index) {
                        return MovieTvItem(
                          overview: bloc.filteredMoviesList[index].overview,
                          posterPath: bloc.filteredMoviesList[index].posterPath,
                          title: bloc.filteredMoviesList[index].title,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowMovieScreen(
                                  isMovie: true,
                                  model: bloc.filteredMoviesList[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  ///----Tv Success
                  if (state is TvShowsSuccessState || state is SearchTvState) {
                    return ListView.builder(
                      itemCount: bloc.filteredTvList.length,
                      itemBuilder: (context, index) {
                        return MovieTvItem(
                          overview: bloc.filteredTvList[index].overview,
                          posterPath: bloc.filteredTvList[index].posterPath,
                          title: bloc.filteredTvList[index].name,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowMovieScreen(
                                  isMovie: false,
                                  model: bloc.filteredTvList[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  ///----Empty
                  return const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.yellow : Colors.white,
        ),
      ),
    );
  }
}
