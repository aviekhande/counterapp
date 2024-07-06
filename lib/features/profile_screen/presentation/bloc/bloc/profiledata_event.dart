part of 'profiledata_bloc.dart';

sealed class ProfiledataEvent extends Equatable {
  const ProfiledataEvent();

  @override
  List<Object> get props => [];
}
class ProfileUpdate extends ProfiledataEvent {}
class ProfileInfoFetch extends ProfiledataEvent{}
