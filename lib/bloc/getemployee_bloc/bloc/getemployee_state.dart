part of 'getemployee_bloc.dart';

sealed class GetemployeeState extends Equatable {
  const GetemployeeState();
  
  @override
  List<Object> get props => [];
}

final class GetemployeeInitial extends GetemployeeState {}
