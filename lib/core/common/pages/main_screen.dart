// lib/feature/main/presentation/pages/main_screen.dart
import 'package:app/core/common/widgets/bottom_navbar_widget.dart';
import 'package:app/feature/epos/epos_page.dart';
import 'package:app/feature/lesson/presentation/pages/home_page.dart';
import 'package:app/feature/character/presentation/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:app/feature/profile/presentation/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CharactersPage(),
    ManasOriginalPage(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
