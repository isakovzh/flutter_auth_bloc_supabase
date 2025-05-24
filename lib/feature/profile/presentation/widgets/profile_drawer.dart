import 'package:app/core/theme/app_pallet.dart';
import 'package:app/core/theme/theme_cubit.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/core/theme/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/l10n/app_localizations.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1F1F1F)
                    : theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.settings,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isDark ? Colors.white : theme.colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color:
                          isDark ? Colors.white : theme.colorScheme.onSurface,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: isDark
                          ? Colors.white.withOpacity(0.1)
                          : theme.colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final isDark = themeMode == ThemeMode.dark;
                return _DrawerItem(
                  icon: isDark ? Icons.dark_mode : Icons.light_mode,
                  title: l10n.changeTheme,
                  trailing: Switch(
                    value: isDark,
                    onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                    activeColor: AppPalette.accent,
                    activeTrackColor: AppPalette.accent.withOpacity(0.3),
                  ),
                  onTap: () => context.read<ThemeCubit>().toggleTheme(),
                  isDark: isDark,
                );
              },
            ),
            BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                final languageCubit = context.read<LanguageCubit>();
                return _DrawerItem(
                  icon: Icons.language,
                  title: l10n.changeLanguage,
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppPalette.accent.withOpacity(0.2)
                          : theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      languageCubit.getCurrentLanguageName(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppPalette.accent
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  onTap: () => languageCubit.cycleLanguage(),
                  isDark: isDark,
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Reset theme to light mode before logging out
                  if (context.read<ThemeCubit>().state == ThemeMode.dark) {
                    context.read<ThemeCubit>().toggleTheme();
                  }
                  context.read<AuthBloc>().add(const AuthLogoutRequested());
                },
                icon: const Icon(Icons.logout),
                label: Text(l10n.logout),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: isDark ? AppPalette.accent : null,
                  foregroundColor: isDark ? Colors.black : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isDark;

  const _DrawerItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppPalette.accent.withOpacity(0.2)
                      : theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isDark ? AppPalette.accent : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isDark ? Colors.white : null,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
