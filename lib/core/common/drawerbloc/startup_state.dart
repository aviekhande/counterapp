part of 'startup_bloc.dart';

sealed class StartupState {
}

final class StartupInitial extends StartupState {}
class StartupCheck extends StartupState{
  bool displayLanguage ;
  bool displaySwitch;
  StartupCheck({required this.displayLanguage, required this.displaySwitch});
}
