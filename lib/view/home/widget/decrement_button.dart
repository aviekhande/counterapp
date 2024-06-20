import 'package:counterapp/bloc/counter_bloc.dart';
import 'package:counterapp/bloc/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MydecrementButton extends StatefulWidget {
  const MydecrementButton({super.key});

  @override
  State<MydecrementButton> createState() => _MydecrementButtonState();
}

class _MydecrementButtonState extends State<MydecrementButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<CounterBloc>().add(Decreament());
        },
        child: const Text("Decrement"));
  }
}
