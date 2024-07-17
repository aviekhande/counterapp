import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/features/profile_details/data/getuserdata.dart';
part 'profiledata_event.dart';
part 'profiledata_state.dart';

class ProfiledataBloc extends Bloc<ProfiledataEvent, ProfiledataState> {
  ProfiledataBloc() : super(ProfiledataInitial()) {
    on<ProfileInfoFetch>(_onProfileUpdate);
    on<ProfileUpdate>(_onProfileImageUpdate);
    on<Logout>(_onLogout);
  }
  void _onLogout(Logout event,Emitter <ProfiledataState> emit ) {
    emit(LogoutState());
  }
  void _onProfileUpdate(
      ProfileInfoFetch event, Emitter<ProfiledataState> emit) async {
    DocumentSnapshot? doc = await getUserData();
    log("${doc?['mobile']}");
    emit(ProfileDataLoading(docSnap: doc));
  }

  void _onProfileImageUpdate(
    ProfileUpdate event, Emitter<ProfiledataState> emit) async {
    emit(ProfileImageLoading(image: event.image));

  }
}
