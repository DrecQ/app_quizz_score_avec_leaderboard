import 'package:app_quizz_score_avec_leaderboard/screens/menu_screen.dart';
import 'package:flutter/material.dart';

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
        fontFamily: 'Roboto', // Utilisez une police personnalisée si disponible
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
  late Animation<double> _pulseAnimation;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Simuler le chargement de l'image
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isImageLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[200]!, Colors.purple[200]!],
          ),
        ),
        child: Stack(
          children: [
            // Animation de l'arrière-plan avec un cadre et l'image
            FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  width: 300,
                  height: 430,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: _isImageLoaded
                        ? Image.asset(
                            'images/img_2.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : ScaleTransition(
                            scale: _pulseAnimation,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Image non chargée',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            // Titre du jeu "Quizz App"
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Quizz App',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bouton pour démarrer le quiz
            Align(
              alignment: FractionalOffset(0.5, 0.85),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuScreen()),
                  );
                },
                child: Text(
                  'Démarrer le quiz',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blue.withOpacity(0.8),
                  elevation: 15,
                  shadowColor: Colors.blue.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
