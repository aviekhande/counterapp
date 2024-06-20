import 'package:bloc/bloc.dart';
import 'package:counterapp/bloc/counter_event.dart';
import 'package:counterapp/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent,CounterState>{
  CounterBloc():super(CounterState()){
    on<Increament>(_increament);
    on<Decreament>(_decreament);
  }
  void _increament(Increament event,Emitter<CounterState> emit){
    emit(state.copyWith(counte: state.counter + 1));
  }
  void _decreament(Decreament event, Emitter<CounterState> emit) {
    emit(state.copyWith(counte: state.counter - 1));
  }
}