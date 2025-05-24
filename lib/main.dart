import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/common/init/init_dependencies.dart';
import 'package:app/core/theme/language_cubit.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/core/theme/theme_cubit.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/auth/presentation/pages/splash_page.dart';
import 'package:app/feature/characters/presentation/bloc/character_bloc.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_bloc.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

import 'l10n/l10n.dart';
import 'l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Optimize Flutter rendering
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Performance optimizations
    if (const bool.fromEnvironment('dart.vm.product')) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }

    // Disable frame rendering when app is not visible
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.paused.toString()) {
        debugPrint('App paused - optimizing rendering');
      }
      return null;
    });

    // Initialize core services in parallel
    final futures = await Future.wait([
      SharedPreferences.getInstance(),
      Hive.initFlutter(),
      initDependencies(),
    ]);

    final prefs = futures[0] as SharedPreferences;

    runApp(MyApp(prefs: prefs));
  } catch (e, stackTrace) {
    print('Error during app initialization: $e');
    print('Stack trace: $stackTrace');
    // Show a user-friendly error screen instead of crashing
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
          child:
              Text('Failed to initialize app. Please restart the application.'),
        ),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LanguageCubit(prefs)),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<LessonBloc>()),
        BlocProvider(
          create: (_) => sl<CharacterBloc>(),
        ),
        // Only add ProfileBloc if it's registered
        if (sl.isRegistered<ProfileBloc>())
          BlocProvider(
              create: (_) =>
                  sl<ProfileBloc>()..add(const GetProfileDetailsEvent())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              // Reload characters when language changes
              context
                  .read<CharacterBloc>()
                  .add(LoadCharactersEvent(locale.languageCode));

              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Manas App',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                locale: locale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
