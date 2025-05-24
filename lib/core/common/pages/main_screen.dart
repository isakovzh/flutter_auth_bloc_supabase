// lib/feature/main/presentation/pages/main_screen.dart
import 'package:app/core/common/widgets/bottom_navbar_widget.dart';
import 'package:app/feature/characters/presentation/pages/character_page.dart';
import 'package:app/feature/epos/epos_page.dart';
import 'package:app/feature/lesson/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app/feature/profile/presentation/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    CharactersPage(),
    ManasChaptersPage(),
    ProfilePage(),
  ];

  // PageView controller for smooth transitions
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    // Animate to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics:
            const NeverScrollableScrollPhysics(), // Disable swipe to prevent accidental navigation
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
