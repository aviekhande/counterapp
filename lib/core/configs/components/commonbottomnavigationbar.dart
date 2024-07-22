import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/posts/presentation/bloc/posts_bloc.dart';

class Commonbottomnavigationbar extends StatefulWidget {
  const Commonbottomnavigationbar({super.key});

  @override
  State<Commonbottomnavigationbar> createState() =>
      _CommonbottomnavigationbarState();
}

int selectedIndex = 0;

class _CommonbottomnavigationbarState extends State<Commonbottomnavigationbar> {
  static const _widgetOptions = [
    HomeScreenRoute(),
    ProductScreenRoute(),
    WishListScreenRoute(),
    PostScreenRoute(),
    ProfileScreenRoute()
  ];

  @override
  void initState() {
    log("init state");
    super.initState();

    // Listen for route changes
    // AutoRouter.of(context).addListener(() {
    //   setState(() {
    //     selectedIndex = _getSelectedIndex(AutoRouter.of(context).current.name);
    //   });
    // });
  }

  // int _getSelectedIndex(String routeName) {
  //   switch (routeName) {
  //     case 'HomeScreenRoute':
  //       return 0;
  //     case 'ProductScreenRoute':
  //       return 1;
  //     case 'WishListScreenRoute':
  //       return 2;
  //     case 'PostScreenRoute':
  //       return 3;
  //     case 'ProfileScreenRoute':
  //       return 4;
  //     default:
  //       return 5;
  //   }
  // }

  void _onItemTapped(int index) {
    log("$index");
    if (index == 3) {
      context.read<PostsBloc>().add(PostsInitialEvent());
    }
    setState(() {
      selectedIndex = index;
    });

    // Navigate to the selected screen
    AutoRouter.of(context).push(_widgetOptions[selectedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.production_quantity_limits),
          label: 'Product',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      showUnselectedLabels: true,
      unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 12.0),
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      selectedIconTheme:
          const IconThemeData(size: 30.0), // Increased size for selected icon
      unselectedIconTheme:
          const IconThemeData(size: 24.0), // Default size for unselected icons
      onTap: _onItemTapped,
    );
  }
}
