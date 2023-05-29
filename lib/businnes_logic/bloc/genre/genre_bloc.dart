import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flixflex/data/repository/genre.dart';
import 'package:flixflex/data/web_services/genre.dart';
import 'package:flixflex/models/genre.dart';
import 'package:meta/meta.dart';

import '../../../presentation/laungaes/main.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreRepository genreRepository;
  GenreBloc({required this.genreRepository}) : super(GenreInitial()) {
    on<GetGenreMovies>(_getGenreMovies);
    on<GetGenreSeries>(_getGenreSeries);
  }
}

FutureOr<void> _getGenreMovies(
    GetGenreMovies event, Emitter<GenreState> emit) async {
  try {
    emit(GenreLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await GenreRepository(GenreWebService()).getGenreMovies();
    print('respose products bloc ${response is List<Genre>}');
    if (response is List<Genre>) {
      emit(GenreLoaded(genres: response));
    } else {
      emit(GenreError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(GenreError(message: e.toString()));
  }
}

FutureOr<void> _getGenreSeries(
    GetGenreSeries event, Emitter<GenreState> emit) async {
  try {
    emit(GenreLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await GenreRepository(GenreWebService()).getGenreSeries();
    print('respose products bloc ${response is List<Genre>}');
    if (response is List<Genre>) {
      emit(GenreLoaded(genres: response));
    } else {
      emit(GenreError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(GenreError(message: e.toString()));
  }
}
