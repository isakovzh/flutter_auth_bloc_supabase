// === Новый экран выбора глав ===
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/l10n/app_localizations.dart';


class EpsChapterModel {
  final String id;
  final String title;
  final String content;
  final String audio;

  EpsChapterModel({
    required this.id,
    required this.title,
    required this.content,
    required this.audio,
  });

  factory EpsChapterModel.fromJson(Map<String, dynamic> json) {
    return EpsChapterModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      audio: json['audio'] as String,
    );
  }
}

class ManasChaptersPage extends StatelessWidget {
  const ManasChaptersPage({super.key});

  Future<List<EpsChapterModel>> _loadChapters() async {
    final data = await rootBundle.loadString('assets/json/manas_chapters.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => EpsChapterModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.eposChapters)),
      body: FutureBuilder<List<EpsChapterModel>>(
        future: _loadChapters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Ошибка загрузки глав'));
          }

          final chapters = snapshot.data!;

          return ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapter = chapters[index];
              return ListTile(
                title: Text(chapter.title),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ManasOriginalPage(chapter: chapter),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ManasOriginalPage extends StatefulWidget {
  final EpsChapterModel chapter;
  const ManasOriginalPage({super.key, required this.chapter});

  @override
  State<ManasOriginalPage> createState() => _ManasOriginalPageState();
}

class _ManasOriginalPageState extends State<ManasOriginalPage> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Слушаем изменения позиции
    _player.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    // Слушаем установку общей длительности
    _player.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });
  }

  void _togglePlay() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(AssetSource(widget.chapter.audio));
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

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.chapter.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.chapter.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// ▶️ Прогресс проигрывания
            Column(
              children: [
                Slider(
                  value: _currentPosition.inSeconds.toDouble(),
                  max: _totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    _player.seek(Duration(seconds: value.toInt()));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_currentPosition)),
                    Text(_formatDuration(_totalDuration)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// ▶️ Кнопка Play / Pause
            ElevatedButton.icon(
              onPressed: _togglePlay,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(isPlaying ? l10n.pause : l10n.listen),
            ),
          ],
        ),
      ),
    );
  }
}
