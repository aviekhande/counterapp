part of 'profiledata_bloc.dart';

sealed class ProfiledataEvent {
}
class ProfileUpdate extends ProfiledataEvent {
  String image;
  ProfileUpdate({required this.image});
}
class ProfileInfoFetch extends ProfiledataEvent{}
