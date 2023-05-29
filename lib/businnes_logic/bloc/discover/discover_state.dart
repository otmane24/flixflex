part of 'discover_bloc.dart';

@immutable
abstract class DiscoverState {}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoading extends DiscoverState {}

class PopularityLoading extends DiscoverState {}

class MoviesLoaded extends DiscoverState {
  final List<Movie> moviesList;

  MoviesLoaded({required this.moviesList});
}

class MoviesPopularityLoaded extends DiscoverState {
  final List<Movie> moviesList;

  MoviesPopularityLoaded({required this.moviesList});
}

class SeriePopularityLoaded extends DiscoverState {
  final List<Serie> seriesList;

  SeriePopularityLoaded({required this.seriesList});
}

class RefreshMoviesLoaded extends DiscoverState {
  final List<Movie> moviesList;

  RefreshMoviesLoaded({required this.moviesList});
}

class RefreshSerieLoaded extends DiscoverState {
  final List<Serie> seriesList;

  RefreshSerieLoaded({required this.seriesList});
}

class SeriesLoaded extends DiscoverState {
  final List<Serie> seriesList;

  SeriesLoaded({required this.seriesList});
}

class DiscoverError extends DiscoverState {
  final String message;

  DiscoverError({required this.message});
}

class PopularityError extends DiscoverState {
  final String message;

  PopularityError({required this.message});
}
