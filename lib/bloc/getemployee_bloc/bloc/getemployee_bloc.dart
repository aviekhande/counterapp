import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getemployee_event.dart';
part 'getemployee_state.dart';

class GetemployeeBloc extends Bloc<GetemployeeEvent, GetemployeeState> {
  GetemployeeBloc() : super(GetemployeeInitial()) {
    on<GetemployeeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
