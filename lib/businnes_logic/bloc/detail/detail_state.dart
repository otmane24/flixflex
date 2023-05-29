part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class MovieDetailLoading extends DetailState {}

class SerieDetailLoading extends DetailState {}

class TagsMovieLoading extends DetailState {}

class TagsSerieLoading extends DetailState {}

class VideoMovieLoading extends DetailState {}

class VideoSerieLoading extends DetailState {}

class MovieDetailLoaded extends DetailState {
  MovieDetail movieDetail;
  MovieDetailLoaded({required this.movieDetail});
}

class SerieDetailLoaded extends DetailState {
  SerieDetail serieDetail;
  SerieDetailLoaded({required this.serieDetail});
}

class TagsMovieLoaded extends DetailState {
  List<Tags> tags;
  TagsMovieLoaded({required this.tags});
}

class TagsSerieLoaded extends DetailState {
  List<Tags> tags;
  TagsSerieLoaded({required this.tags});
}

class VideoMovieLoaded extends DetailState {
  VideoMovie videoMovie;
  VideoMovieLoaded({required this.videoMovie});
}

class VideoSerieLoaded extends DetailState {
  VideoMovie videoMovie;
  VideoSerieLoaded({required this.videoMovie});
}

class MovieDetailError extends DetailState {
  final String message;

  MovieDetailError({required this.message});
}

class SerieDetailError extends DetailState {
  final String message;

  SerieDetailError({required this.message});
}

class TagsMovieError extends DetailState {
  final String message;

  TagsMovieError({required this.message});
}

class VideoMovieError extends DetailState {
  final String message;

  VideoMovieError({required this.message});
}

class TagsSerieError extends DetailState {
  final String message;

  TagsSerieError({required this.message});
}

class VideoSerieError extends DetailState {
  final String message;

  VideoSerieError({required this.message});
}
