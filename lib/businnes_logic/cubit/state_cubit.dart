import 'package:bloc/bloc.dart';

// use this State Cubit to rebuild exact widget
// we make this globally to use it every where when we need it to refresh just a specific widget
// bloc provider create one instance for each bloc builder
class StateCubit extends Cubit<bool> {
  StateCubit(bool initialState) : super(initialState);

  void setBlocState({bool? newState}) => emit(newState ?? !state);

  @override
  void onChange(Change<bool> change) {
    super.onChange(change);
  }
}
