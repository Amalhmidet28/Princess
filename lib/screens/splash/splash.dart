import 'package:cutfx/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
/// A splash screen widget that displays a logo and a small icon.
///
/// This widget creates a splash screen with a time indicator at the top,
/// a main logo image in the center, and a smaller icon at the bottom.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 120,
              right:100,
              top: 11,
              bottom: 163,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            

                // Main logo image
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Image.asset(
                    'asset/artwork.png',
                    width: 146,
                    fit: BoxFit.contain,
                  ),
                ),

                // Bottom icon
                Padding(
                  padding: const EdgeInsets.only(top: 220),
                  child: Image.asset(
                    'asset/Frame.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
