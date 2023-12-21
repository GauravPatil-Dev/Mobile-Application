import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp5/features/home/data/repos/home_repo_impl.dart';

import '../../../bookmark/presentation/view/bookmark_screen.dart';
import 'home_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  HomeRepoImpl homeRepoImpl = HomeRepoImpl(); // Example instantiation
  List<Widget> _screens() {
    return [
      HomeScreen(homeRepoImpl),
      const BookmarkScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screenList = _screens();
    return Scaffold(
      body: screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bookmark),
            label: 'Bookmark',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CupertinoColors.activeBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
