part of 'profiledata_bloc.dart';

class ProfiledataState {}
final class ProfiledataInitial extends ProfiledataState {}
final class ProfileDataLoading extends ProfiledataState {
  final DocumentSnapshot? docSnap;
  ProfileDataLoading({required this.docSnap});
}
