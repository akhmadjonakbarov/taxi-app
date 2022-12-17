import 'package:flutter/material.dart';
import 'package:taxi_app/pages/driver/announcement/announcement_page.dart';
import 'package:taxi_app/pages/driver/profile/profile_page.dart';
import 'package:taxi_app/pages/driver/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List _pages = const [
    HomePage(),
    AnnouncementPage(),
    ProfilePage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (selectedItem) {
          setState(() {
            _currentIndex = selectedItem;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Arizalar",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_alt,
            ),
            label: "E'lonlar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
