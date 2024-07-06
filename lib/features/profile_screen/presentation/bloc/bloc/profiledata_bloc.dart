import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'profiledata_event.dart';
part 'profiledata_state.dart';

class ProfiledataBloc extends Bloc<ProfiledataEvent, ProfiledataState> {
  ProfiledataBloc() : super(ProfiledataInitial()) {
    on<ProfiledataEvent>(_onProfileUpdate);
  }
  void _onProfileUpdate(event, emit) {}
}
