import 'package:bloc/bloc.dart';

part 'appbar_event.dart';
part 'appbar_state.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  AppbarBloc() : super(AppbarInitial()) {
    on<ClearSearch>(_controllerClear);
  }
  void _controllerClear(ClearSearch event, Emitter<AppbarState> emit){
    emit(AppbarInitial());
  }
}
