part of 'discover_bloc.dart';

@immutable
abstract class DiscoverEvent {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class GetMovies extends DiscoverEvent {
  int nextPage;
  String? genreId;
  GetMovies({required this.nextPage, this.genreId});

  @override
  List<Object> get props => [];
}

class GetPopularityMovies extends DiscoverEvent {
  const GetPopularityMovies();

  @override
  List<Object> get props => [];
}

class GetPopularitySerie extends DiscoverEvent {
  const GetPopularitySerie();

  @override
  List<Object> get props => [];
}

class RefreshMovies extends DiscoverEvent {
  int nextPage;
  String? genreId;
  RefreshMovies({required this.nextPage, this.genreId});

  @override
  List<Object> get props => [];
}

class GetSeries extends DiscoverEvent {
  int nextPage;
  String? genreId;
  GetSeries({required this.nextPage, this.genreId});

  @override
  List<Object> get props => [];
}

class RefreshSerie extends DiscoverEvent {
  int nextPage;
  String? genreId;
  RefreshSerie({required this.nextPage, this.genreId});

  @override
  List<Object> get props => [];
}
