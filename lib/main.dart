import 'package:app/core/theme/theme.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/auth/presentation/pages/splash_page.dart';
import 'package:app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
