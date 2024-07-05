part of 'profiledata_bloc.dart';

sealed class ProfiledataState extends Equatable {
  const ProfiledataState();
  
  @override
  List<Object> get props => [];
}

final class ProfiledataInitial extends ProfiledataState {}
final class ProfileDataLoading extends ProfiledataState {
  final Map<String, Object> profileInfo;
  const ProfileDataLoading({required this.profileInfo});

}
