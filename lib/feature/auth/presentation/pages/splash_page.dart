import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app/feature/auth/presentation/pages/signup_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showHomeScreen = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showHomeScreen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return showHomeScreen ? const SignUpPage() : buildSplashScreen();
  }

  Widget buildSplashScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
