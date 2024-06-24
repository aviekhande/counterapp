// import 'package:counterapp/bloc/home_bloc/counter_bloc.dart';
// import 'package:counterapp/bloc/home_bloc/counter_state.dart';
// import 'package:counterapp/view/employeeinfo/employee_screen.dart';
// import 'package:counterapp/view/insertemployeedata/insertemployeedata.dart';
import 'package:counterapp/bloc/posts_bloc/posts_bloc.dart';
import 'package:counterapp/view/postscreen/postscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'widget/widget.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocListener<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is PostsLoaded) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PostScreen()));
                  context.loaderOverlay.hide();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text(
                "HomeScreen",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: LoaderOverlay(
              child: Center(
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 114, 182, 214)),
                      minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                  onPressed: () {
                    context.loaderOverlay.show();
                    context.read<PostsBloc>().add(const PostsEvent());
                  },
                  child: const Text(
                    "Load Posts",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                //    Column(
                //     children: [
                //       const SizedBox(
                //         height: 100,
                //       ),
                //       BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
                //         return Text("${state.counter}");
                //       }),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       const Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           MyincrementButton(),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           MydecrementButton(),
                //         ],
                //       ),
      
                //       ElevatedButton(
                //         style: const ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                //         onPressed: (){
      
                //         },
                //         child: const Text("Load Posts"),
                //       )
                //     ],
                //   ),
                // )
                // floatingActionButton: Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     FloatingActionButton.extended(
                //       onPressed: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) => const EmployeeInfo()));
                //       },
                //       label: const Text("Get Employee Data"),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     FloatingActionButton.extended(
                //       onPressed: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) => const InsertEmpData()));
                //       },
                //       label: const Text("Post Employee Data"),
                //     ),
                //   ],
                // ),
              ),
            ),
          )),
    );
  }
}
