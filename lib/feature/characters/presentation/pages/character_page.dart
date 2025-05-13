import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/feature/characters/presentation/bloc/character_bloc.dart';
import 'package:app/feature/characters/presentation/pages/guess_character_page.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        leading: null,
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CharacterError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }

          if (state is CharacterLoaded) {
            final characters = [...state.characters];
            characters.sort((a, b) {
              if (a.isUnlocked == b.isUnlocked) return 0;
              return a.isUnlocked ? -1 : 1;
            });

            final unlockedCount = characters.where((c) => c.isUnlocked).length;
            final totalCount = characters.length;
            final progress = totalCount == 0 ? 0.0 : unlockedCount / totalCount;

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  /// 🔥 Прогресс-блок
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Characters Unlocked",
                            style: theme.textTheme.bodyLarge),
                        Text(
                          "$unlockedCount / $totalCount unlocked",
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: theme.dividerColor,
                          minHeight: 10,
                        ),
                      ],
                    ),
                  ),

                  /// 🔥 Сетка персонажей
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
                                                color: Colors.grey.shade400,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.broken_image,
                                                    size: 48,
                                                    color: Colors.white,
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

          return const Center(child: Text('Нет данных'));
        },
      ),
    );
  }
}
