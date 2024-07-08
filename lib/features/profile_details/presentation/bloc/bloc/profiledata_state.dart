part of 'profiledata_bloc.dart';

sealed class ProfiledataState extends Equatable {
  const ProfiledataState();

  @override
  List<Object> get props => [];
}

final class ProfiledataInitial extends ProfiledataState {}

final class ProfileDataLoading extends ProfiledataState {
  DocumentSnapshot? docSnap;
  ProfileDataLoading({required this.docSnap});
}
