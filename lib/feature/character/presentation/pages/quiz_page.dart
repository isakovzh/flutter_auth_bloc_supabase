import 'package:flutter/material.dart';
import 'guess_character_page.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  final List<Map<String, String>> characters = const [
    {
      'id': 'manas',
      'name': 'Manas',
      'description':
          'A great hero who united the Kyrgyz tribes and led them to victory.',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Manas_hero.jpg/220px-Manas_hero.jpg',
    },
    {
      'id': 'bakai',
      'name': 'Bakai',
      'description': 'A wise advisor and spiritual mentor of Manas.',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Bakai_Sage.png/220px-Bakai_Sage.png',
    },
    {
      'id': 'kanykei',
      'name': 'Kanykei',
      'description': 'The loyal and brave wife of Manas.',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Kanykei.jpg/220px-Kanykei.jpg',
    },
  ];

  // 👇 Здесь будут храниться ID угаданных персонажей
  final List<String> unlockedCharacters = const ['manas', 'kanykei'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          final isUnlocked = unlockedCharacters.contains(character['id']);

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(character['image']!),
              ),
              title: isUnlocked
                  ? Text(
                      character['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const Text('???',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
              subtitle: isUnlocked
                  ? Text(character['description']!)
                  : const Text('Guess to unlock'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GuessCharacterPage(
                      characterName: character['name']!,
                      characterDescription: character['description']!,
                      imageUrl: character['image']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
