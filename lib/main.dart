import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Language Phrases'),
        ),
        body: LanguageTiles(),
      ),
    );
  }
}

class LanguageTiles extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<String> phrases = [
    'salut',
    'mă numesc',
    'cum ești?',
    'sunt bine'
  ];

  LanguageTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: phrases.length * 2,
      itemBuilder: (context, index) {
        final isRomanian = index % 2 == 0;
        final phraseIndex = index ~/ 2;
        final phrase = phrases[phraseIndex];
        final languageLabel = isRomanian ? '(Română)' : '(Germană)';
        final String assetNumber = (phraseIndex * 2 + (isRomanian ? 1 : 2)).toString().padLeft(2, '0');
        final String assetPath = 'res/$assetNumber.mp3';
        return SoundTile(
          label: '$phrase $languageLabel',
          assetPath: assetPath,
          onTap: () async {
              await audioPlayer.setSource(AssetSource(assetPath));
              await audioPlayer.resume();
          },
        );
      },
    );
  }
}

class SoundTile extends StatelessWidget {
  final String label;
  final String assetPath;
  final VoidCallback onTap;

  const SoundTile({
    Key? key,
    required this.label,
    required this.assetPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }
}
