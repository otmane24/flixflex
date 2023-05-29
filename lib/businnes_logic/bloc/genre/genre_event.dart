part of 'genre_bloc.dart';

@immutable
abstract class GenreEvent {
  const GenreEvent();

  @override
  List<Object> get props => [];
}

class GetGenreMovies extends GenreEvent {
  const GetGenreMovies();

  @override
  List<Object> get props => [];
}

class GetGenreSeries extends GenreEvent {
  const GetGenreSeries();

  @override
  List<Object> get props => [];
}
