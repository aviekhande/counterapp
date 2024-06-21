import 'package:counterapp/bloc/home_bloc/counter_bloc.dart';
import 'package:counterapp/bloc/home_bloc/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyincrementButton extends StatefulWidget {
  const MyincrementButton({super.key});

  @override
  State<MyincrementButton> createState() => _MyincrementButtonState();
}

class _MyincrementButtonState extends State<MyincrementButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<CounterBloc>().add(Increament());
        },
        child: const Text("Increment"));
  }
}
