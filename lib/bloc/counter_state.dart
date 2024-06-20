import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({this.counter = 1});

    @override
  List<Object> get props => [counter];

  CounterState copyWith({int? counte}) {
    return CounterState(counter: counte??counter);
  }
}
