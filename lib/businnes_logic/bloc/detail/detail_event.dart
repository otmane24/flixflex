part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetail extends DetailEvent {
  int id;
  GetMovieDetail({required this.id});

  @override
  List<Object> get props => [];
}

class GetSerieDetail extends DetailEvent {
  int id;
  GetSerieDetail({required this.id});

  @override
  List<Object> get props => [];
}

class GetTagsMovie extends DetailEvent {
  int id;
  GetTagsMovie({required this.id});

  @override
  List<Object> get props => [];
}

class GetVideoMovie extends DetailEvent {
  int id;
  GetVideoMovie({required this.id});

  @override
  List<Object> get props => [];
}

class GetTagsSerie extends DetailEvent {
  int id;
  GetTagsSerie({required this.id});

  @override
  List<Object> get props => [];
}

class GetVideoSerie extends DetailEvent {
  int id;
  GetVideoSerie({required this.id});

  @override
  List<Object> get props => [];
}
