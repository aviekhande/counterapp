part of 'profiledata_bloc.dart';

class ProfiledataState {}

final class ProfiledataInitial extends ProfiledataState {}

class ProfileDataLoading extends ProfiledataState {
  DocumentSnapshot? docSnap;
  ProfileDataLoading({required this.docSnap});
}

class ProfileImageLoading extends ProfiledataState {
  String image;
  ProfileImageLoading({required this.image});
}
class LogoutState extends ProfiledataState{}
