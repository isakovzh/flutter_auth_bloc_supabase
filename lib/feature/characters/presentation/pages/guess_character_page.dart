import 'package:app/feature/characters/domain/entity/characters.dart';
import 'package:app/feature/characters/presentation/bloc/character_bloc.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/l10n/app_localizations.dart';

class GuessCharacterPage extends StatefulWidget {
  final CharacterEntity character;

  const GuessCharacterPage({super.key, required this.character});

  @override
  State<GuessCharacterPage> createState() => _GuessCharacterPageState();
}

class _GuessCharacterPageState extends State<GuessCharacterPage> {
  final TextEditingController _controller = TextEditingController();
  String? _feedback;

  void _checkAnswer() {
    final input = _controller.text.trim().toLowerCase();
    final correct = widget.character.name.trim().toLowerCase();
    final l10n = AppLocalizations.of(context);

    if (input == correct) {
      if (!widget.character.isUnlocked) {
        print("📢 Отправляем AddXPEvent");
        context
            .read<CharacterBloc>()
            .add(UnlockCharacterEvent(widget.character.id));
        context.read<ProfileBloc>().add(const AddXPEvent(15));
      }

      setState(() {
        _feedback = l10n.guessCharacterCorrect(widget.character.name);
      });

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      setState(() {
        _feedback = l10n.guessCharacterIncorrect;
      });
    }
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        height: 500,
        width: 400,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error, size: 100),
      );
    } else {
      return Image.network(
        imageUrl,
        height: 180,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 100),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.guessCharacterTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _buildImage(widget.character.imageUrl)),
            const SizedBox(height: 20),
            Text(
              widget.character.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: l10n.guessCharacterInputLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text(l10n.guessCharacterSubmitButton),
            ),
            const SizedBox(height: 20),
            if (_feedback != null)
              Text(
                _feedback!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _feedback!.startsWith("✅") ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
