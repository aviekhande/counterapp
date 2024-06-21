import 'package:counterapp/bloc/posts_bloc/posts_bloc.dart';
import 'package:counterapp/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomeScreen()),
    );
  }
}
