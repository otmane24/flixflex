part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMulti extends SearchEvent {
  int nextPage;
  String searchKey;
  SearchMulti({required this.nextPage, required this.searchKey});

  @override
  List<Object> get props => [];
}

class RefreshSearchMulti extends SearchEvent {
  int nextPage;
  String searchKey;
  RefreshSearchMulti({required this.nextPage, required this.searchKey});

  @override
  List<Object> get props => [];
}
