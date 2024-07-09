import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/features/profile_details/data/getuserdata.dart';
import 'package:equatable/equatable.dart';
part 'profiledata_event.dart';
part 'profiledata_state.dart';

class ProfiledataBloc extends Bloc<ProfiledataEvent, ProfiledataState> {
  ProfiledataBloc() : super(ProfiledataInitial()) {
    on<ProfileInfoFetch>(_onProfileUpdate);
  }
  void _onProfileUpdate(
      ProfileInfoFetch event, Emitter<ProfiledataState> emit) async {
    DocumentSnapshot? doc = await getUserData();
    log("${doc?['mobile']}");
    emit(ProfileDataLoading(docSnap: doc));
  }
}
