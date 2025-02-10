import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialisation de l'AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true); // Répète l'animation en boucle

    // Configuration de l'animation de fondu
    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Stack(
        children: [
          // Arrière-plan avec l'image et l'animation de fondu
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/image.webp'), // Remplace par ton image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Contenu principal
          Align(
            alignment: FractionalOffset(
                0.5, 0.85), // Positionne le bouton à 85% de la hauteur
            child: ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton
                print('Démarrer le quiz');
              },
              child: Text(
                'Démarrer le quiz',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor:
                    Colors.blue.withOpacity(0.8), // Couleur du bouton
                elevation: 10, // Ombre du bouton
              ),
            ),
          ),
        ],
      ),
    );
  }
}
