import 'package:companyfoxl/Screen/LoginScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _borderRadiusAnimation;
  late Animation<double> _rotation;
  late Animation<double> _opacity;
  late Animation<double> _buttonOpacity;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    Timer(const Duration(microseconds: 800), () {
      _controller.forward();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(const Duration(microseconds: 800), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get screen dimensions
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    _sizeAnimation = Tween<double>(
      begin: screenHeight, // Use height for full screen size
      end: 150, // Final size for width and height
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8,
            curve: Curves.easeInOut), // First half for size change
      ),
    );

    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0,
            curve: Curves.easeInOut), // Second half for rotation
      ),
    );

    // Animation for border radius from 5.0 to circular (75.0)
    _borderRadiusAnimation = Tween<double>(begin: 10.0, end: 75.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0,
            curve:
                Curves.easeInOut), // Second half for border radius transition
      ),
    );

    // Opacity animation to show the image after rotation completes
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0,
            curve: Curves
                .easeInOut), // Show image towards the end of the animation
      ),
    );

    // Opacity animation for the button to appear at the end
    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0,
            curve: Curves.easeInOut), // Button appears towards the very end
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/LoginpageBGimage.jpeg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius:
                      BorderRadius.circular(_borderRadiusAnimation.value),
                  child: RotationTransition(
                    turns: _rotation,
                    child: Container(
                      width: _sizeAnimation.value,
                      height: _sizeAnimation.value,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff01B2E4),
                            Color(0xffFFFFFF),
                            Color(0xff0554C2)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: ScaleTransition(
                          scale: _opacity,
                          child: Image.asset(
                            'images/FOXL Logo.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Positioned button at the bottom center of the screen
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _backgroundColor = const Color(0xffd0140bf);
  Color _buttonColor = const Color(0xff0A0130);

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _backgroundColor = const Color(0xff0A0130);
        _buttonColor = const Color(0xff0039DB);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'images/LoginpageBGimage.jpeg', // Replace with your  background image path
            fit: BoxFit.cover,
          ),
          // Overlay with color change and button
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            color: _backgroundColor.withOpacity(0.6),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/FOXL Logo.png', // Replace with your logo path
                  ),
                ],
              ),
            ),
          ),
          // Positioned container with button at the bottom
          Positioned(
            bottom: 30, // Adjust distance from the bottom
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(
                  color: _buttonColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                    // Define what happens when the button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor, // Button color
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
