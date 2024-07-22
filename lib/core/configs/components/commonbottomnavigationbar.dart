// import 'package:auto_route/auto_route.dart';
// import 'package:counterapp/core/routes/routes_import.gr.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../features/posts/presentation/bloc/posts_bloc.dart';

// class Commonbottomnavigationbar extends StatefulWidget {
//   const Commonbottomnavigationbar({super.key});

//   @override
//   State<Commonbottomnavigationbar> createState() =>
//       _CommonbottomnavigationbarState();
// }

// class _CommonbottomnavigationbarState extends State<Commonbottomnavigationbar> {
//   static const _widgetOptions = [
//     HomeScreenRoute(),
//     ProductScreenRoute(),
//     WishListScreenRoute(),
//     PostScreenRoute(),
//     ProfileScreenRoute()
//   ];
//   int _selectedIndex = 0;

// //   void _onItemTapped(int index) {
// //     AutoRouter.of(context).push(_widgetOptions[index]);

// //   }
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     // Navigate to the selected screen
//     AutoRouter.of(context).push(_widgetOptions[index]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_filled),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.production_quantity_limits),
//           label: 'Product',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: 'Wishlist',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.send),
//           label: 'Posts',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       selectedItemColor: Colors.amber[800],
//       unselectedItemColor: Colors.grey,
//       selectedIconTheme:
//           const IconThemeData(size: 30.0), // Increased size for selected icon
//       unselectedIconTheme:
//           const IconThemeData(size: 24.0), // Default size for unselected icons
//       onTap: (index) {
//         if (index == 3) {
//           // Trigger the PostsInitialEvent when navigating to the Posts screen
//           context.read<PostsBloc>().add(PostsInitialEvent());
//         }
//         _onItemTapped(index);
//       },
//     );
// // Container(
// //       color:const Color.fromARGB(255, 114, 182, 214) ,
// //       padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
// //       height: 60.h,
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           GestureDetector(
// //             onTap: () => _onItemTapped(0),
// //             child: const Column(
// //               children: [
// //                 Icon(Icons.home_filled),
// //                 Text("Home")
// //               ],
// //             ),
// //           ),
// //           GestureDetector(
// //             onTap: () => _onItemTapped(1),
// //             child: const Column(
// //               children: [
// //                 Icon(Icons.production_quantity_limits),
// //                 Text("Product")
// //               ],
// //             ),
// //           ),
// //           GestureDetector(
// //             onTap: () => _onItemTapped(2),
// //             child: const Column(
// //               children: [
// //                 Icon(Icons.favorite),
// //                 Text("Wishlist")
// //               ],
// //             ),
// //           ),
// //             GestureDetector(
// //             onTap: () {
// //                context.read<PostsBloc>().add(PostsInitialEvent());
// //               _onItemTapped(3);},
// //             child: const Column(
// //               children: [
// //                 Icon(Icons.send),
// //                 Text("Posts")
// //               ],
// //             ),
// //           ),
// //           GestureDetector(
// //             onTap: () => _onItemTapped(4),
// //             child: const Column(
// //               children: [
// //                 Icon(Icons.person),
// //                 Text("Profile")
// //               ],
// //             ),
// //           ),
// //       ],
//     //   ),
//     // );
//   }
// }
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

int _selectedIndex = 0;

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
    // TODO: implement initState
    log("init state");
    super.initState();
  }

  void _onItemTapped(int index) {
    log("$index");
    if (index == 3) {
      context.read<PostsBloc>().add(PostsInitialEvent());
    }
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the selected screen
    AutoRouter.of(context).push(_widgetOptions[_selectedIndex]);
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
        unselectedLabelStyle:
            const TextStyle(color: Colors.grey, fontSize: 12.0),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        selectedIconTheme:
            const IconThemeData(size: 30.0), // Increased size for selected icon
        unselectedIconTheme: const IconThemeData(
            size: 24.0), // Default size for unselected icons
        onTap: _onItemTapped);
  }
}
