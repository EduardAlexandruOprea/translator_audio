import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

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
  LanguageTiles({super.key});
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<String> phrases = <String>['salut', 'mă numesc', 'cum ești?', 'sunt bine'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: phrases.length * 2,
      itemBuilder: (BuildContext context, int index) {
        final bool isRomanian = index.isEven;
        final int phraseIndex = index ~/ 2;
        final String phrase = phrases[phraseIndex];
        final String languageLabel = isRomanian ? '(Română)' : '(Germană)';
        final String assetNumber = (phraseIndex * 2 + (isRomanian ? 1 : 2)).toString().padLeft(2, '0');
        final String assetPath = 'res/$assetNumber.mp3';
        return SoundTile(
          label: '$phrase $languageLabel',
          assetPath: assetPath,
          onTap: () async {
            await audioPlayer.stop();
            await audioPlayer.setSource(AssetSource(assetPath));
            await audioPlayer.resume();
          },
        );
      },
    );
  }
}

class SoundTile extends StatelessWidget {
  const SoundTile({
    super.key,
    required this.label,
    required this.assetPath,
    required this.onTap,
  });

  final String label;
  final String assetPath;
  final VoidCallback onTap;

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

  @override
  Future<void> debugFillProperties(DiagnosticPropertiesBuilder properties) async {
    super.debugFillProperties(properties);
    properties.add(StringProperty('assetPath', assetPath));
  }
}
