// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:app/core/common/pages/main_screen.dart';
import 'package:app/feature/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Setup fade animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Schedule navigation after animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateBasedOnSession();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateBasedOnSession() async {
    try {
      // Minimum splash screen duration
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      final session = Supabase.instance.client.auth.currentSession;

      // Use pushAndRemoveUntil for cleaner navigation
      await Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              session != null ? const MainScreen() : const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
        (route) => false,
      );
    } catch (e) {
      print('Navigation error: $e');
      // Fallback to login page on error
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Image.asset(
                'assets/images/splash.png',
                width: size.width,
                height: size.height,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
