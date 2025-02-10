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
  bool _isImageLoaded = false; // Pour gérer le chargement de l'image

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
          // Animation de l'arrière-plan avec un cadre et l'image
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), // Bord arrondi
                  color: Colors.white.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                width: 300,
                height: 400,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      30), // Bord arrondi pour l'image aussi
                  child: _isImageLoaded
                      ? Image.asset(
                          'assets/images/image.webp', // Ton image ici
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Center(
                          child:
                              CircularProgressIndicator(), // Affiche un loader en attendant
                        ),
                ),
              ),
            ),
          ),
          // Bouton pour démarrer le quiz
          Align(
            alignment: FractionalOffset(0.5, 0.85),
            child: ElevatedButton(
              onPressed: () {
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
                backgroundColor: Colors.blue.withOpacity(0.8),
                elevation: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
