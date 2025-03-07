// ignore_for_file: use_build_context_synchronously

import 'package:cutfx/screens/omboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set status bar to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Navigate to OnboardingScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });

    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width <= 640;
    final isMediumScreen = screenSize.width <= 991 && screenSize.width > 640;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/fd42f617e2b41796249cc9a3f7fbc9a3ca989dfa', // This will be replaced with the actual image URL
              fit: BoxFit.cover,
              semanticLabel: 'Background image',
            ),
          ),

          // Main content
          Positioned(
            bottom: isSmallScreen ? 60 : 73,
            left: isSmallScreen ? 24 : 32,
            right: isSmallScreen ? 24 : 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Welcome text
                Text(
                  'Welcome to',
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Figtree',
                    fontSize: isSmallScreen ? 36 : (isMediumScreen ? 42 : 48),
                    fontWeight: FontWeight.w700,
                    height: 1.1, // lineHeight 110%
                  ),
                  semanticsLabel: 'Welcome to',
                ),

                const SizedBox(height: 12),

                // Princess text with gradient
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: AppColors.princessGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // Approximate 286deg in CSS
                    transform: const GradientRotation(5.0),
                  ).createShader(bounds),
                  child: Text(
                    'Princess',
                    style: TextStyle(
                      color: Colors.white, // This color will be replaced by the gradient
                      fontFamily: 'Figtree',
                      fontSize: isSmallScreen ? 48 : (isMediumScreen ? 56 : 64),
                      fontWeight: FontWeight.w700,
                      height: 1.1, // lineHeight 110%
                    ),
                    semanticsLabel: 'Princess',
                  ),
                ),

                const SizedBox(height: 24),

                // Tagline
                Text(
                  'Effortless Beauty & Grooming.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Figtree',
                    fontSize: isSmallScreen ? 14 : (isMediumScreen ? 16 : 18),
                    fontWeight: FontWeight.w500,
                    height: 1.4, // lineHeight 140%
                    letterSpacing: 0.2,
                  ),
                  semanticsLabel: 'Effortless Beauty and Grooming',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
