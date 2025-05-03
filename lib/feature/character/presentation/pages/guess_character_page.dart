import 'package:flutter/material.dart';

class GuessCharacterPage extends StatefulWidget {
  final String characterName;
  final String characterDescription;
  final String imageUrl;

  const GuessCharacterPage({
    super.key,
    required this.characterName,
    required this.characterDescription,
    required this.imageUrl,
  });

  @override
  State<GuessCharacterPage> createState() => _GuessCharacterPageState();
}

class _GuessCharacterPageState extends State<GuessCharacterPage> {
  final TextEditingController _controller = TextEditingController();
  String? _result;

  void _checkAnswer() {
    final input = _controller.text.trim().toLowerCase();
    final correct = widget.characterName.trim().toLowerCase();

    if (input == correct) {
      setState(() {
        _result = "✅ Correct! This is ${widget.characterName}.";
      });
    } else {
      setState(() {
        _result = "❌ Wrong. Try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guess Character')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(widget.imageUrl, height: 180),
            ),
            const SizedBox(height: 20),
            Text(
              widget.characterDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Who is this?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            if (_result != null)
              Text(
                _result!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _result!.startsWith("✅") ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
