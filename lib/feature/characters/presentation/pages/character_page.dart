import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/feature/characters/presentation/bloc/character_bloc.dart';
import 'package:app/feature/characters/presentation/pages/guess_character_page.dart';
import 'package:app/core/theme/language_cubit.dart';
import 'package:app/l10n/app_localizations.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // Load characters with current locale when the page is built or language changes
    return BlocListener<LanguageCubit, Locale>(
      listener: (context, locale) {
        context
            .read<CharacterBloc>()
            .add(LoadCharactersEvent(locale.languageCode));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.characters),
          leading: null,
        ),
        body: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CharacterError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      l10n.error(state.message),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            }

            if (state is CharacterLoaded) {
              final characters = [...state.characters];
              characters.sort((a, b) {
                if (a.isUnlocked == b.isUnlocked) return 0;
                return a.isUnlocked ? -1 : 1;
              });

              final unlockedCount =
                  characters.where((c) => c.isUnlocked).length;
              final totalCount = characters.length;
              final progress =
                  totalCount == 0 ? 0.0 : unlockedCount / totalCount;

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (context) {
                              try {
                                return BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, profileState) {
                                    if (profileState is ProfileLoaded) {
                                      return Text(
                                          l10n.xpPoints(profileState.profile.xp
                                              .toString()),
                                          style: theme.textTheme.bodyLarge);
                                    }
                                    return Text(l10n.xpPoints('0'),
                                        style: theme.textTheme.bodyLarge);
                                  },
                                );
                              } catch (e) {
                                // Return default XP display if ProfileBloc is not available
                                return Text(l10n.xpPoints('0'),
                                    style: theme.textTheme.bodyLarge);
                              }
                            },
                          ),
                          Text(
                            l10n.charactersUnlocked(
                                unlockedCount, characters.length),
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor:
                                theme.progressIndicatorTheme.linearTrackColor,
                            color: theme.progressIndicatorTheme.color,
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                      ),
                    ),

                    /// 🔥 Прогресс-блок
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   margin: const EdgeInsets.only(bottom: 20),
                    //   decoration: BoxDecoration(
                    //     color: theme.colorScheme.surface,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Characters Unlocked",
                    //           style: theme.textTheme.bodyLarge),
                    //       Text(
                    //         "$unlockedCount / $totalCount unlocked",
                    //         style: theme.textTheme.bodyMedium,
                    //       ),
                    //       const SizedBox(height: 10),
                    //       LinearProgressIndicator(
                    //         value: progress,
                    //         backgroundColor: theme.dividerColor,
                    //         minHeight: 10,
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                        children: characters.map((character) {
                          final isUnlocked = character.isUnlocked;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      GuessCharacterPage(character: character),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isUnlocked
                                    ? Colors.white
                                    : Colors.grey.shade300,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: isUnlocked
                                          ? Image.asset(
                                              character.imageUrl,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey.shade100,
                                                  child: const Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(),
                                                        SizedBox(height: 8),
                                                        Icon(
                                                          Icons
                                                              .image_not_supported,
                                                          size: 24,
                                                          color: Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Container(
                                              color: Colors.grey.shade400,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.lock,
                                                  size: 48,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isUnlocked ? character.name : '???',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: isUnlocked
                                            ? Colors.black
                                            : Colors.grey.shade600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}
