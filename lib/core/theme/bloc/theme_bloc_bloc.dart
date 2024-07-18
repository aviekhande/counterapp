import 'package:bloc/bloc.dart';
import 'package:counterapp/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

class ThemeBlocBloc extends Bloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBlocBloc() : super(ThemeBlocInitial()) {
    on<ThemeBlocEvent>((event, emit) {
      emit(ThemeChangeBloc(
         themeData:  event.themeData
      ));
    });
  }
}
