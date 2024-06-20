import 'package:counterapp/bloc/counter_bloc.dart';
import 'package:counterapp/bloc/counter_state.dart';
import 'package:counterapp/view/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100,),
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
              return Text("${state.counter}");
            }),
            const SizedBox(height: 10,),
           const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyincrementButton(),
                    SizedBox(width: 10,),
                MydecrementButton(),
               
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Myproduct()));
          },
          label:const Text("Get Product Data"),
          ),
          const SizedBox(height: 10,),
           FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Myproduct()));
            },
            label: const Text("Post Product Data"),
          ),
        ],
      ),
    );
  }
}
