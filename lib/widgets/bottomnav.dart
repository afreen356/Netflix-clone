
import 'package:clone/screens/comingsoon.dart';
import 'package:clone/screens/downloads.dart';
import 'package:clone/screens/home.dart';
import 'package:clone/screens/search.dart';

import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {

  
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

   

  final List<Widget>_screens=[
    const HomePge(),
    const SearchScreen(),
   const  ComingSoon(),
    const DownloadScreen(),
    const Scaffold(),

  ];

  int selectedIndex =0;

  Map<String,IconData> navItems={
    'Home':Icons.home,
    'Search':Icons.search,
    'Coming soon':Icons.queue_play_next,
    'Downloads':Icons.download,
    'Menue':Icons.menu
  };

   void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        
        items: navItems.entries.map((entry) {
          return BottomNavigationBarItem(
            icon: Icon(entry.value, size: 18),
            label: entry.key,
          );
        }).toList(),
         currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
  
      ),
    );
  }
}