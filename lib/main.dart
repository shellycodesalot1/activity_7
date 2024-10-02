import 'package:flutter/material.dart';
import 'dart:math' as math; // Import for rotation

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      _isVisible ? _controller.reverse() : _controller.forward();
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
      appBar: AppBar(
        title: Text('Interactive Sky Animation'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue[100]!, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center( // Center the Stack in the body
          child: Stack(
            alignment: Alignment.center, // Center align children
            children: [
              RotationTransition(
                turns: _controller.drive(Tween(begin: 0.0, end: 1.0)), // Rotation animation
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 2), // Duration for fading
                  curve: Curves.easeInOut, // Smooth fade
                  child: Image.network(
                    'https://static.vecteezy.com/system/resources/thumbnails/042/725/838/small/cut-out-white-realistic-clouds-ozone-atmosphere-3d-illustration-file-png.png',
                    width: 300, // Increased width for a larger cloud
                    height: 150, // Adjust height as needed
                  ),
                ),
              ),
              GestureDetector(
                onTap: toggleVisibility, // Taps will toggle visibility
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 2), // Duration for fading
                  curve: Curves.easeInOut, // Smooth fade
                  child: const Text(
                    'Hello, Sky!',
                    style: TextStyle(
                      fontSize: 50, // Increased font size for better visibility
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Pacifico', // Sky-themed font
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.blueGrey,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.cloud),
      ),
    );
  }
}
