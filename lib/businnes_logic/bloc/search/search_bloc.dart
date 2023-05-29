import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flixflex/data/repository/search.dart';
import 'package:flixflex/data/web_services/search.dart';
import 'package:meta/meta.dart';

import '../../../presentation/laungaes/main.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;
  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<RefreshSearchMulti>(_refreshSearchMulti);
    on<SearchMulti>(_searchMulti);
  }
}

FutureOr<void> _searchMulti(
    SearchMulti event, Emitter<SearchState> emit) async {
  try {
    emit(SearchLoading());
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await SearchRepository(SearchWebService())
        .searchMulti(nextPage: event.nextPage, searchKey: event.searchKey);

    if (response is Map<String, dynamic>) {
      emit(SearchLoaded(searchResult: response));
    } else {
      emit(SearchError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(SearchError(message: e.toString()));
  }
}

FutureOr<void> _refreshSearchMulti(
    RefreshSearchMulti event, Emitter<SearchState> emit) async {
  try {
    // After receiving the otp, we will verify the otp and then will create a credenti;al from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
    final response = await SearchRepository(SearchWebService())
        .searchMulti(nextPage: event.nextPage, searchKey: event.searchKey);

    if (response is Map<String, dynamic>) {
      emit(RefreshSearchLoaded(searchResult: response));
    } else {
      emit(SearchError(message: AppLanguage.strings.errorBloc));
    }
  } catch (e) {
    emit(SearchError(message: e.toString()));
  }
}
