import 'package:app/core/theme/app_pallet.dart';
import 'package:app/core/common/pages/main_screen.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/auth/presentation/widgets/auth_textform_filled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/feature/auth/presentation/pages/login_page.dart';
import 'package:app/core/theme/theme_cubit.dart';
import 'package:app/core/theme/language_cubit.dart';
import 'package:app/l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          // Theme toggle
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? AppPalette.accent : theme.colorScheme.primary,
            ),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
          // Language toggle
          BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return TextButton(
                onPressed: () => context.read<LanguageCubit>().cycleLanguage(),
                child: Text(
                  locale.languageCode.toUpperCase(),
                  style: TextStyle(
                    color:
                        isDark ? AppPalette.accent : theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                isDark ? 'assets/svg/svg_dark.svg' : 'assets/svg/auth_orn.svg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                l10n.registration,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppPalette.accent : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                    if (state is AuthSuccess) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthTextFormField(
                            label: l10n.username,
                            hintText: l10n.enterUsername,
                            icon: Icons.person,
                            controller: _usernameController,
                          ),
                          const SizedBox(height: 20),
                          AuthTextFormField(
                            label: l10n.email,
                            hintText: l10n.enterEmail,
                            icon: Icons.mail,
                            controller: _emailController,
                          ),
                          const SizedBox(height: 20),
                          AuthTextFormField(
                            label: l10n.password,
                            hintText: l10n.enterPassword,
                            icon: Icons.vpn_key,
                            obscureText: _obscurePassword,
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 20),
                          AuthTextFormField(
                            label: l10n.confirmPassword,
                            hintText: l10n.reenterPassword,
                            icon: Icons.vpn_key,
                            obscureText: _obscureConfirmPassword,
                            controller: _confirmPasswordController,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark
                                    ? AppPalette.accent
                                    : theme.colorScheme.primary,
                                foregroundColor:
                                    isDark ? Colors.black : Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: state is AuthLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                              AuthSignUpRequested(
                                                name: _usernameController.text
                                                    .trim(),
                                                email: _emailController.text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                              ),
                                            );
                                      }
                                    },
                              child: state is AuthLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    )
                                  : Text(
                                      l10n.signUp,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                l10n.haveAccount,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: isDark
                                      ? AppPalette.accent
                                      : theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
