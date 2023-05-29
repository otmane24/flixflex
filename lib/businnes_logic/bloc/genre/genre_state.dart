part of 'genre_bloc.dart';

@immutable
abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  List<Genre> genres;
  GenreLoaded({required this.genres});
}

class GenreError extends GenreState {
  final String message;

  GenreError({required this.message});
}
