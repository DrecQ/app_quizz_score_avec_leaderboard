import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classement'),
      ),
      body: Center(
        child: Text('Ceci est l\'écran du classement.'),
      ),
    );
  }
}
