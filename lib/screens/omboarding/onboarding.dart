import 'package:cutfx/screens/login/email_login_screen.dart';
import 'package:cutfx/screens/login/login_option_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 640;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 428),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'asset/image1.png',
                        width: 366,
                        height: 366,
                        fit: BoxFit.contain,
                        semanticLabel: 'Services illustration',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 380),
                                    margin: EdgeInsets.only(
                                      bottom: isSmallScreen ? 40 : 60,
                                    ),
                                    child: Text(
                                      'Tailored Services, Just for You.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'RecklessNeue',
                                        fontSize: isSmallScreen ? 32 : 40,
                                        fontWeight: FontWeight.w700,
                                        height: 1.1,
                                        color: AppTheme.textPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildDot(isActive: true),
                                      const SizedBox(width: 6),
                                      _buildDot(),
                                      const SizedBox(width: 6),
                                      _buildDot(),
                                    ],
                                  ),
                                  const SizedBox(height: 250),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        constraints:
                                            const BoxConstraints(maxWidth: 300),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const OnboardingScreen2(),
                                              ),
                                            );
                                          },
                                          style: AppTheme.primaryButtonStyle(
                                              isSmallScreen: isSmallScreen),
                                          child: Text(
                                            'Next',
                                            style: GoogleFonts.figtree(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.2,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//pour les points
  Widget _buildDot({bool isActive = false}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryButtonColor : AppTheme.dotColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width <= 640;
    final bool isMediumScreen = screenSize.width <= 991;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 428),
          //margin: EdgeInsets.symmetric(horizontal: auto),
          child: Column(
            children: [
              // Status bar - hide on small screens
              if (!isSmallScreen) const StatusBar(),

              // Main content
              Expanded(
                child: Column(
                  children: [
                    // Image container
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              isSmallScreen ? 12 : (isMediumScreen ? 16 : 24),
                          vertical:
                              isSmallScreen ? 16 : (isMediumScreen ? 24 : 32),
                        ),
                        child: Center(
                          child: Image.asset(
                            'asset/image2.png', // Replace with actual image path
                            width: double.infinity,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            semanticLabel: 'Glowing checkmark on phone',
                          ),
                        ),
                      ),
                    ),

                    // Text section
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        isSmallScreen ? 16 : (isMediumScreen ? 16 : 24),
                        isSmallScreen ? 20 : (isMediumScreen ? 24 : 32),
                        isSmallScreen ? 16 : (isMediumScreen ? 16 : 24),
                        isSmallScreen ? 32 : (isMediumScreen ? 36 : 48),
                      ),
                      child: Column(
                        children: [
                          // Heading
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: isSmallScreen
                                  ? 32
                                  : (isMediumScreen ? 40 : 60),
                            ),
                            child: Text(
                              'Book with Ease,Anytime',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'RecklessNeue',
                                fontSize: isSmallScreen ? 32 : 40,
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                          ),

                          // Navigation dots
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: isSmallScreen
                                  ? 32
                                  : (isMediumScreen ? 40 : 60),
                            ),
                            child: const NavigationDots(
                              count: 3,
                              activeIndex: 2,
                            ),
                          ),

                          // Next button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OnboardingScreen3(), // Remplace avec le bon nom de ton écran
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFA57864),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: isSmallScreen ? 16 : 18,
                                  horizontal: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                elevation: 10,
                                shadowColor: const Color(0x403E2B23),
                              ),
                              child: Text(
                                'Next',
                                style: GoogleFonts.figtree(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;
    final isMediumScreen = screenWidth <= 991 && screenWidth > 640;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomStatusBar(),

            // Image container (moved to the top)
            Container(
              width: isSmallScreen ? 320 : (isMediumScreen ? 280 : 336),
              height: isSmallScreen ? 300 : (isMediumScreen ? 245 : 294),
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: isSmallScreen ? -10 : -40,
                    top: isSmallScreen ? -252 : -100,
                    child: Container(
                      width: isSmallScreen ? 336 : (isMediumScreen ? 412 : 495),
                      height:
                          isSmallScreen ? 294 : (isMediumScreen ? 412 : 495),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(-14, 5),
                            blurRadius: 40,
                            color: Colors.black.withOpacity(0.06),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'asset/image3.png',
                        fit: BoxFit.cover,
                        semanticLabel: 'Barbershop tools',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isSmallScreen ? 20 : 40),

            // Text section
            Column(
              children: [
                // Heading
                Text(
                  'Top-Rated Experts, Premium Care.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'RecklessNeue-Bold',
                    fontSize: isSmallScreen ? 32 : 40,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),

                SizedBox(height: isSmallScreen ? 60 : 60),

                // Pagination dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.dotColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.dotColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.dotColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // Get Started button
           ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginOptionScreen()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: AppTheme.buttonColor,
    elevation: 15,
    shadowColor: const Color(0x403E2B23),
    minimumSize: const Size(double.infinity, 56),
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  ),
  child: Text(
    'Get Started',
    style: GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
      color: Colors.white,
      height: 1.4,
    ),
  ),
),
const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CustomStatusBar extends StatelessWidget {
  const CustomStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 640;

    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Status icons
          if (!isSmallScreen)
            Row(
              children: [
                // Signal strength icons
                Row(
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 2),
                      width: 3,
                      height: 8 + (index * 2),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
        ],
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time

          // Status icons
          Row(
            children: [
              // Signal strength
              Row(
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 2),
                    width: 3,
                    height: 8 + (index * 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(index == 0 ? 0.4 : 1),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),

              // WiFi icon
              // Battery ico
            ],
          ),
        ],
      ),
    );
  }
}

class NavigationDots extends StatelessWidget {
  final int count;
  final int activeIndex;
  final Color dotColor;
  final double dotSize;
  final double spacing;

  const NavigationDots({
    Key? key,
    required this.count,
    required this.activeIndex,
    this.dotColor = const Color(0xFFD1C7BA),
    this.dotSize = 8.0,
    this.spacing = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          margin: EdgeInsets.only(right: index < count - 1 ? spacing : 0),
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}

class AppTheme {
  static const Color textPrimaryColor = Color(0xFF1C1B1A);
  static const Color primaryButtonColor = Color(0xFFA57864);
  static const Color dotColor = Color(0xFFD1C7BA);
  static const Color textPrimary = Color(0xFF1C1B1A);
  static const Color buttonColor = Color(0xFFA57864);

  static TextStyle buttonTextStyle() {
    return GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
      height: 1.4,
      color: Colors.white,
    );
  }

  static TextStyle statusBarTextStyle = GoogleFonts.figtree(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: Colors.black,
  );

  static ButtonStyle primaryButtonStyle({required bool isSmallScreen}) {
    return ElevatedButton.styleFrom(
      backgroundColor: primaryButtonColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 16 : 18,
        horizontal: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      elevation: 4,
      shadowColor: const Color(0x403E2B23),
    );
  }
}
