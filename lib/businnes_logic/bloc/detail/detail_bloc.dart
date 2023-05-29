import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flixflex/data/repository/detail.dart';
import 'package:flixflex/data/web_services/detail.dart';
import 'package:flixflex/models/detail_movie.dart';
import 'package:flixflex/models/detail_serie.dart';
import 'package:flixflex/models/video_movie.dart';
import 'package:meta/meta.dart';

import '../../../models/tags.dart';
import '../../../presentation/laungaes/main.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailRepository detailRepository;
  DetailBloc({required this.detailRepository}) : super(DetailInitial()) {
    on<GetMovieDetail>(_getMovieDetail);
    on<GetSerieDetail>(_getSerieDetail);
    on<GetTagsMovie>(_getTagsMovie);
    on<GetVideoMovie>(_getVideoMovie);
    on<GetTagsSerie>(_getTagsSerie);
    on<GetVideoSerie>(_getVideoSerie);
  }
}

FutureOr<void> _getMovieDetail(
    GetMovieDetail event, Emitter<DetailState> emit) async {
  try {
    emit(MovieDetailLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DetailRepository(DetailWebService()).getMovieDetail(id: event.id);

    if (response is MovieDetail) {
      emit(MovieDetailLoaded(movieDetail: response));
    } else {
      emit(MovieDetailError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(MovieDetailError(message: e.toString()));
  }
}

FutureOr<void> _getSerieDetail(
    GetSerieDetail event, Emitter<DetailState> emit) async {
  try {
    emit(SerieDetailLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DetailRepository(DetailWebService()).getSerieDetail(id: event.id);

    if (response is SerieDetail) {
      emit(SerieDetailLoaded(serieDetail: response));
    } else {
      emit(SerieDetailError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(SerieDetailError(message: e.toString()));
  }
}

FutureOr<void> _getTagsMovie(
    GetTagsMovie event, Emitter<DetailState> emit) async {
  try {
    emit(TagsMovieLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DetailRepository(DetailWebService()).getTagsMovie(id: event.id);

    if (response is List<Tags>) {
      emit(TagsMovieLoaded(tags: response));
    } else {
      emit(TagsMovieError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(TagsMovieError(message: e.toString()));
  }
}

FutureOr<void> _getVideoMovie(
    GetVideoMovie event, Emitter<DetailState> emit) async {
  try {
    emit(VideoMovieLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DetailRepository(DetailWebService()).getVideoMovie(id: event.id);

    if (response is VideoMovie) {
      emit(VideoMovieLoaded(videoMovie: response));
    } else {
      emit(VideoMovieError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(VideoMovieError(message: e.toString()));
  }
}

FutureOr<void> _getTagsSerie(
    GetTagsSerie event, Emitter<DetailState> emit) async {
  try {
    emit(TagsSerieLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DetailRepository(DetailWebService()).getTagsSerie(id: event.id);

    if (response is List<Tags>) {
      emit(TagsSerieLoaded(tags: response));
    } else {
      emit(TagsSerieError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(TagsSerieError(message: e.toString()));
  }
}

FutureOr<void> _getVideoSerie(
    GetVideoSerie event, Emitter<DetailState> emit) async {
  try {
    emit(VideoSerieLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DetailRepository(DetailWebService()).getVideoSerie(id: event.id);

    if (response is VideoMovie) {
      emit(VideoSerieLoaded(videoMovie: response));
    } else {
      emit(VideoSerieError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(VideoSerieError(message: e.toString()));
  }
}
