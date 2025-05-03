import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ManasOriginalPage extends StatefulWidget {
  const ManasOriginalPage({super.key});

  @override
  State<ManasOriginalPage> createState() => _ManasOriginalPageState();
}

class _ManasOriginalPageState extends State<ManasOriginalPage> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  final String audioUrl =
      'https://example.com/audio/manas_birth.mp3'; // заменишь на актуальный
  final String text = '''
Manas was born in a time of great darkness...
His mother dreamed of a mighty eagle soaring over the mountains.
From birth, he showed signs of greatness...

(real text 😁😁😁)
  ''';

  void _togglePlay() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(audioUrl));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manas: The Original Epic')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'The Birth of Manas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _togglePlay,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(isPlaying ? 'Pause Audio' : 'Play Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
