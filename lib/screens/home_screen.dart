import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound() async {
    await _audioPlayer.play(AssetSource('winning.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App', style: GoogleFonts.lato()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _playSound();
                Navigator.pushNamed(context, '/regle');
              },
              child: Text('Règle du jeu'),
            ),
            ElevatedButton(
              onPressed: () {
                _playSound();
                Navigator.pushNamed(context, '/solo');
              },
              child: Text('Jouer en solo'),
            ),
            ElevatedButton(
              onPressed: () {
                _playSound();
                Navigator.pushNamed(context, '/duoSetup');
              },
              child: Text('Jouer en duo'),
            ),
            ElevatedButton(
              onPressed: () {
                _playSound();
                Navigator.pushNamed(context, '/leaderboard');
              },
              child: Text('Score'),
            ),
          ],
        ),
      ),
    );
  }
}
