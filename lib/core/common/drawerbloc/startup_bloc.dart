import 'package:bloc/bloc.dart';
import '../data/getisdisplay.dart';
part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  StartupBloc() : super(StartupInitial()) {
    on<CheckEvent>((event, emit) async {
      List<bool> isDisplay = await getData();
      emit(StartupCheck(
        displayLanguage: isDisplay[0],
        displaySwitch: isDisplay[1],
      ));
    });
  }
}
