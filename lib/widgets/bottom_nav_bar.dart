import 'package:flutter/material.dart';
import 'package:netfllix_clone/screens/home_screen.dart';
import 'package:netfllix_clone/screens/more_screen.dart';
import 'package:netfllix_clone/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: 70,
            color: Colors.black,
            child: TabBar(tabs: [
              Tab(icon: Icon(Icons.home),
              text: 'Home',),
              Tab(icon: Icon(Icons.search),
                text: 'Search',),
              Tab(icon: Icon(Icons.photo_library_outlined),
                text: 'Hot & News',),
            ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xff999999),
            ),
          ),
          body: TabBarView(children: [
            HomeScreen(),
            SearchScreen(),
            MoreScreen()
          ]),
        ));
  }
}
