part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class RefreshSearchLoaded extends SearchState {
  final Map<String, dynamic> searchResult;

  RefreshSearchLoaded({required this.searchResult});

  get moviesList => null;
}

class SearchLoaded extends SearchState {
  Map<String, dynamic> searchResult;
  SearchLoaded({required this.searchResult});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
