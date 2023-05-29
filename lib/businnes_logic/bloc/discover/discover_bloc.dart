import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flixflex/data/repository/discover.dart';
import 'package:flixflex/data/web_services/discover.dart';
import 'package:flixflex/models/movie.dart';
import 'package:flixflex/models/serie.dart';
import 'package:meta/meta.dart';

import '../../../presentation/laungaes/main.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverRepository discoverRepository;
  DiscoverBloc({required this.discoverRepository}) : super(DiscoverInitial()) {
    on<GetMovies>(_getMovies);
    on<GetSeries>(_getSeries);
    on<GetPopularityMovies>(_getPopularityMovies);
    on<GetPopularitySerie>(_getPopularitySerie);
    on<RefreshMovies>(_refreshMovies);
    on<RefreshSerie>(_refreshSeries);
  }
}

FutureOr<void> _getMovies(GetMovies event, Emitter<DiscoverState> emit) async {
  try {
    emit(DiscoverLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await DiscoverRepository(DiscoverWebService())
        .getMovies(nextPage: event.nextPage, genreId: event.genreId);
    print('respose products bloc ${response is List<Movie>}');
    if (response is List<Movie>) {
      emit(MoviesLoaded(moviesList: response));
    } else {
      emit(DiscoverError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(DiscoverError(message: e.toString()));
  }
}

FutureOr<void> _getPopularityMovies(
    GetPopularityMovies event, Emitter<DiscoverState> emit) async {
  try {
    emit(PopularityLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DiscoverRepository(DiscoverWebService()).getPopularityMovies();
    print('respose products bloc ${response is List<Movie>}');
    if (response is List<Movie>) {
      emit(MoviesPopularityLoaded(moviesList: response));
    } else {
      emit(PopularityError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(PopularityError(message: e.toString()));
  }
}

FutureOr<void> _getPopularitySerie(
    GetPopularitySerie event, Emitter<DiscoverState> emit) async {
  try {
    emit(PopularityLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response =
        await DiscoverRepository(DiscoverWebService()).getPopularitySerie();
    print('respose products bloc ${response is List<Movie>}');
    if (response is List<Serie>) {
      emit(SeriePopularityLoaded(seriesList: response));
    } else {
      emit(PopularityError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(PopularityError(message: e.toString()));
  }
}

FutureOr<void> _refreshMovies(
    RefreshMovies event, Emitter<DiscoverState> emit) async {
  try {
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await DiscoverRepository(DiscoverWebService())
        .getMovies(nextPage: event.nextPage, genreId: event.genreId);
    print('respose products bloc ${response is List<Movie>}');
    if (response is List<Movie>) {
      emit(RefreshMoviesLoaded(moviesList: response));
    } else {
      emit(DiscoverError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(DiscoverError(message: e.toString()));
  }
}

FutureOr<void> _refreshSeries(
    RefreshSerie event, Emitter<DiscoverState> emit) async {
  try {
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await DiscoverRepository(DiscoverWebService())
        .getSeries(nextPage: event.nextPage, genreId: event.genreId);
    print('respose products bloc ${response is List<Serie>}');
    if (response is List<Serie>) {
      emit(RefreshSerieLoaded(seriesList: response));
    } else {
      emit(DiscoverError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(DiscoverError(message: e.toString()));
  }
}

FutureOr<void> _getSeries(GetSeries event, Emitter<DiscoverState> emit) async {
  try {
    emit(DiscoverLoading());
    // After receiving the otp, we will verify the otp and then will create a credential from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await DiscoverRepository(DiscoverWebService())
        .getSeries(nextPage: event.nextPage, genreId: event.genreId);
    print('respose products blocs $response ');
    if (response is List<Serie>) {
      emit(SeriesLoaded(seriesList: response));
    } else {
      emit(DiscoverError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(DiscoverError(message: e.toString()));
  }
}
