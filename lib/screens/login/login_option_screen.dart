// ignore_for_file: unused_import

import 'dart:io';

import 'package:cutfx/bloc/login/login_bloc.dart';
import 'package:cutfx/screens/constants/app_colors.dart';
import 'package:cutfx/screens/login/email_login_screen.dart';
import 'package:cutfx/screens/omboarding/onboarding.dart';
import 'package:cutfx/screens/web/web_view_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class LoginOptionScreen extends StatelessWidget {
  const LoginOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 640;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 428),
          margin: const EdgeInsets.symmetric(horizontal:BorderSide.strokeAlignCenter),
          child: Column(
            children: [
              // Status bar
              //const StatusBar(),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                  child: Column(
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const BackButton(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Logo
                      const AppLogo(
                        width: 130,
                        height: 153,
                      ),

                      const SizedBox(height: 40),

                      // Title
                      Text(
                        "Let's you in",
                        style: isMobile
                            ? AppStyles.titleStyleMobile
                            : AppStyles.titleStyle,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // Social login buttons
                      FacebookLoginButton(
                        onPressed: () {
                          // Handle Facebook login
                        },
                      ),

                      const SizedBox(height: 16),

                      GoogleLoginButton(
                        onPressed: () {
                          // Handle Google login
                        },
                      ),

                      const SizedBox(height: 16),

                      AppleLoginButton(
                        onPressed: () {
                          // Handle Apple login
                        },
                      ),

                      const SizedBox(height: 24),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.border,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'or',
                              style: AppStyles.dividerTextStyle,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.border,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Sign in button
                    GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailLoginScreen()), // Assure-toi que ConnexionScreen est bien importé
    );
  },
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 18),
    decoration: AppStyles.primaryButtonDecoration,
    child: const Text(
      'Sign in with password',
      style: AppStyles.primaryButtonTextStyle,
      textAlign: TextAlign.center,
    ),
  ),
)

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
}
class SocialLoginButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: MediaQuery.of(context).size.width < 640
            ? const EdgeInsets.symmetric(vertical: 16, horizontal: 24)
            : const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        decoration: AppStyles.socialButtonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              text,
              style: AppStyles.buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

// Pre-defined social login buttons
class FacebookLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FacebookLoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      text: 'Continue with Facebook',
      icon: const FacebookIcon(),
      onPressed: onPressed,
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      text: 'Continue with Google',
      icon: const GoogleIcon(),
      onPressed: onPressed,
    );
  }
}

class AppleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleLoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      text: 'Continue with Apple',
      icon: const AppleIcon(),
      onPressed: onPressed,
    );
  }
}

// Social icons
class FacebookIcon extends StatelessWidget {
  const FacebookIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: FacebookIconPainter(),
      ),
    );
  }
}

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: GoogleIconPainter(),
      ),
    );
  }
}

class AppleIcon extends StatelessWidget {
  const AppleIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: AppleIconPainter(),
      ),
    );
  }
}

// Custom painters for social icons
class FacebookIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    // Background circle
    final Path circlePath = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create gradient for the circle
    final Gradient gradient = LinearGradient(
      begin: const Alignment(-0.5, -0.5),
      end: const Alignment(0.8, 0.8),
      colors: [
        AppColors.facebookBlue,
        AppColors.facebookBlueDark,
      ],
    );

    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(circlePath, paint);

    // Facebook 'f' logo
    paint.shader = null;
    paint.color = Colors.white;

    final Path fPath = Path();
    fPath.moveTo(size.width * 0.58, size.height * 0.7);
    fPath.lineTo(size.width * 0.7, size.height * 0.7);
    fPath.lineTo(size.width * 0.72, size.height * 0.56);
    fPath.lineTo(size.width * 0.58, size.height * 0.56);
    fPath.lineTo(size.width * 0.58, size.height * 0.49);
    fPath.cubicTo(
      size.width * 0.58, size.height * 0.43,
      size.width * 0.59, size.height * 0.38,
      size.width * 0.64, size.height * 0.38
    );
    fPath.lineTo(size.width * 0.72, size.height * 0.38);
    fPath.lineTo(size.width * 0.72, size.height * 0.26);
    fPath.cubicTo(
      size.width * 0.71, size.height * 0.26,
      size.width * 0.68, size.height * 0.25,
      size.width * 0.63, size.height * 0.25
    );
    fPath.cubicTo(
      size.width * 0.52, size.height * 0.25,
      size.width * 0.45, size.height * 0.32,
      size.width * 0.45, size.height * 0.47
    );
    fPath.lineTo(size.width * 0.45, size.height * 0.56);
    fPath.lineTo(size.width * 0.32, size.height * 0.56);
    fPath.lineTo(size.width * 0.32, size.height * 0.7);
    fPath.lineTo(size.width * 0.45, size.height * 0.7);
    fPath.lineTo(size.width * 0.45, size.height);
    fPath.cubicTo(
      size.width * 0.47, size.height,
      size.width * 0.49, size.height,
      size.width * 0.51, size.height
    );
    fPath.cubicTo(
      size.width * 0.53, size.height,
      size.width * 0.56, size.height,
      size.width * 0.58, size.height * 0.99
    );
    fPath.close();

    canvas.drawPath(fPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    // G logo
    // Blue part
    paint.color = AppColors.googleBlue;
    final Path bluePath = Path();
    bluePath.moveTo(size.width * 0.98, size.height * 0.51);
    bluePath.lineTo(size.width * 0.98, size.height * 0.41);
    bluePath.lineTo(size.width * 0.51, size.height * 0.41);
    bluePath.lineTo(size.width * 0.51, size.height * 0.59);
    bluePath.lineTo(size.width * 0.78, size.height * 0.59);
    bluePath.cubicTo(
      size.width * 0.74, size.height * 0.64,
      size.width * 0.68, size.height * 0.71,
      size.width * 0.59, size.height * 0.75
    );
    bluePath.lineTo(size.width * 0.59, size.height * 0.76);
    bluePath.lineTo(size.width * 0.82, size.height * 0.87);
    bluePath.lineTo(size.width * 0.83, size.height * 0.88);
    bluePath.cubicTo(
      size.width * 0.93, size.height * 0.79,
      size.width * 0.98, size.height * 0.66,
      size.width * 0.98, size.height * 0.51
    );
    bluePath.close();
    canvas.drawPath(bluePath, paint);

    // Green part
    paint.color = AppColors.googleGreen;
    final Path greenPath = Path();
    greenPath.moveTo(size.width * 0.51, size.height);
    greenPath.cubicTo(
      size.width * 0.64, size.height,
      size.width * 0.75, size.height * 0.95,
      size.width * 0.83, size.height * 0.88
    );
    greenPath.lineTo(size.width * 0.82, size.height * 0.87);
    greenPath.lineTo(size.width * 0.59, size.height * 0.76);
    greenPath.lineTo(size.width * 0.59, size.height * 0.75);
    greenPath.cubicTo(
      size.width * 0.55, size.height * 0.78,
      size.width * 0.49, size.height * 0.8,
      size.width * 0.41, size.height * 0.8
    );
    greenPath.cubicTo(
      size.width * 0.28, size.height * 0.8,
      size.width * 0.17, size.height * 0.72,
      size.width * 0.13, size.height * 0.6
    );
    greenPath.lineTo(size.width * 0.12, size.height * 0.6);
    greenPath.lineTo(size.width * 0.07, size.height * 0.72);
    greenPath.lineTo(size.width * 0.07, size.height * 0.72);
    greenPath.cubicTo(
      size.width * 0.15, size.height * 0.89,
      size.width * 0.32, size.height,
      size.width * 0.51, size.height
    );
    greenPath.close();
    canvas.drawPath(greenPath, paint);

    // Yellow part
    paint.color = AppColors.googleYellow;
    final Path yellowPath = Path();
    yellowPath.moveTo(size.width * 0.13, size.height * 0.6);
    yellowPath.cubicTo(
      size.width * 0.12, size.height * 0.57,
      size.width * 0.11, size.height * 0.53,
      size.width * 0.11, size.height * 0.5
    );
    yellowPath.cubicTo(
      size.width * 0.11, size.height * 0.47,
      size.width * 0.12, size.height * 0.43,
      size.width * 0.13, size.height * 0.4
    );
    yellowPath.lineTo(size.width * 0.13, size.height * 0.39);
    yellowPath.lineTo(size.width * 0.08, size.height * 0.27);
    yellowPath.lineTo(size.width * 0.07, size.height * 0.27);
    yellowPath.cubicTo(
      size.width * 0.04, size.height * 0.34,
      size.width * 0.02, size.height * 0.42,
      size.width * 0.02, size.height * 0.5
    );
    yellowPath.cubicTo(
      size.width * 0.02, size.height * 0.58,
      size.width * 0.04, size.height * 0.66,
      size.width * 0.07, size.height * 0.72
    );
    yellowPath.lineTo(size.width * 0.13, size.height * 0.6);
    yellowPath.close();
    canvas.drawPath(yellowPath, paint);

    // Red part
    paint.color = AppColors.googleRed;
    final Path redPath = Path();
    redPath.moveTo(size.width * 0.51, size.height * 0.19);
    redPath.cubicTo(
      size.width * 0.6, size.height * 0.19,
      size.width * 0.66, size.height * 0.23,
      size.width * 0.7, size.height * 0.27
    );
    redPath.lineTo(size.width * 0.84, size.height * 0.13);
    redPath.cubicTo(
      size.width * 0.75, size.height * 0.05,
      size.width * 0.64, size.height * 0,
      size.width * 0.51, size.height * 0
    );
    redPath.cubicTo(
      size.width * 0.32, size.height * 0,
      size.width * 0.15, size.height * 0.11,
      size.width * 0.07, size.height * 0.27
    );
    redPath.lineTo(size.width * 0.13, size.height * 0.4);
    redPath.cubicTo(
      size.width * 0.17, size.height * 0.28,
      size.width * 0.28, size.height * 0.19,
      size.width * 0.51, size.height * 0.19
    );
    redPath.close();
    canvas.drawPath(redPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AppleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.appleBlack;

    // Apple logo
    final Path applePath = Path();

    // Top leaf part
    applePath.moveTo(size.width * 0.7, size.height * 0.0005);
    applePath.cubicTo(
      size.width * 0.7, size.height * -0.002,
      size.width * 0.62, size.height * 0.0014,
      size.width * 0.55, size.height * 0.074
    );
    applePath.cubicTo(
      size.width * 0.49, size.height * 0.146,
      size.width * 0.5, size.height * 0.229,
      size.width * 0.5, size.height * 0.231
    );
    applePath.cubicTo(
      size.width * 0.5, size.height * 0.233,
      size.width * 0.59, size.height * 0.236,
      size.width * 0.65, size.height * 0.152
    );
    applePath.cubicTo(
      size.width * 0.71, size.height * 0.068,
      size.width * 0.7, size.height * 0.003,
      size.width * 0.7, size.height * 0.0005
    );
    applePath.close();

    // Main apple body
    applePath.moveTo(size.width * 0.91, size.height * 0.734);
    applePath.cubicTo(
      size.width * 0.9, size.height * 0.728,
      size.width * 0.76, size.height * 0.657,
      size.width * 0.77, size.height * 0.52
    );
    applePath.cubicTo(
      size.width * 0.79, size.height * 0.383,
      size.width * 0.88, size.height * 0.346,
      size.width * 0.88, size.height * 0.342
    );
    applePath.cubicTo(
      size.width * 0.88, size.height * 0.338,
      size.width * 0.84, size.height * 0.292,
      size.width * 0.8, size.height * 0.269
    );
    applePath.cubicTo(
      size.width * 0.77, size.height * 0.253,
      size.width * 0.74, size.height * 0.244,
      size.width * 0.7, size.height * 0.242
    );
    applePath.cubicTo(
      size.width * 0.7, size.height * 0.242,
      size.width * 0.67, size.height * 0.236,
      size.width * 0.63, size.height * 0.249
    );
    applePath.cubicTo(
      size.width * 0.59, size.height * 0.258,
      size.width * 0.52, size.height * 0.286,
      size.width * 0.5, size.height * 0.287
    );
    applePath.cubicTo(
      size.width * 0.48, size.height * 0.288,
      size.width * 0.42, size.height * 0.255,
      size.width * 0.36, size.height * 0.246
    );
    applePath.cubicTo(
      size.width * 0.32, size.height * 0.238,
      size.width * 0.28, size.height * 0.254,
      size.width * 0.25, size.height * 0.266
    );
    applePath.cubicTo(
      size.width * 0.22, size.height * 0.278,
      size.width * 0.16, size.height * 0.313,
      size.width * 0.12, size.height * 0.406
    );
    applePath.cubicTo(
      size.width * 0.08, size.height * 0.499,
      size.width * 0.1, size.height * 0.646,
      size.width * 0.11, size.height * 0.691
    );
    applePath.cubicTo(
      size.width * 0.13, size.height * 0.737,
      size.width * 0.15, size.height * 0.811,
      size.width * 0.19, size.height * 0.866
    );
    applePath.cubicTo(
      size.width * 0.23, size.height * 0.927,
      size.width * 0.28, size.height * 0.97,
      size.width * 0.3, size.height * 0.985
    );
    applePath.cubicTo(
      size.width * 0.32, size.height * 0.999,
      size.width * 0.37, size.height,
      size.width * 0.41, size.height * 0.989
    );
    applePath.cubicTo(
      size.width * 0.44, size.height * 0.969,
      size.width * 0.5, size.height * 0.958,
      size.width * 0.52, size.height * 0.959
    );
    applePath.cubicTo(
      size.width * 0.54, size.height * 0.96,
      size.width * 0.59, size.height * 0.969,
      size.width * 0.63, size.height * 0.993
    );
    applePath.cubicTo(
      size.width * 0.67, size.height,
      size.width * 0.7, size.height,
      size.width * 0.74, size.height * 0.986
    );
    applePath.cubicTo(
      size.width * 0.77, size.height * 0.973,
      size.width * 0.82, size.height * 0.92,
      size.width * 0.88, size.height * 0.814
    );
    applePath.cubicTo(
      size.width * 0.9, size.height * 0.765,
      size.width * 0.91, size.height * 0.738,
      size.width * 0.91, size.height * 0.734
    );
    applePath.close();

    canvas.drawPath(applePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class AppStyles {
  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'RecklessNeue',
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleStyleMobile = TextStyle(
    fontFamily: 'RecklessNeue',
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle primaryButtonTextStyle = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle dividerTextStyle = TextStyle(
    fontFamily: 'Figtree',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );


  // Button styles
  static final ButtonStyle socialButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.background),
  );

  static final ButtonStyle primaryButtonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(vertical: 18),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
    elevation: MaterialStateProperty.all<double>(0),
  );

  // Decorations
  static final BoxDecoration socialButtonDecoration = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: AppColors.border),
  );

  static final BoxDecoration primaryButtonDecoration = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(100),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF3E2B23).withOpacity(0.25),
        offset: const Offset(4, 8),
        blurRadius: 24,
      ),
    ],
  );
}


class BackButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.textPrimary;

    // Horizontal line
    final Path horizontalPath = Path();
    horizontalPath.moveTo(size.width * 0.97, size.height * 0.5);
    horizontalPath.cubicTo(
      size.width * 0.97, size.height * 0.53,
      size.width * 0.94, size.height * 0.55,
      size.width * 0.91, size.height * 0.55
    );
    horizontalPath.lineTo(size.width * 0.17, size.height * 0.55);
    horizontalPath.cubicTo(
      size.width * 0.14, size.height * 0.55,
      size.width * 0.11, size.height * 0.53,
      size.width * 0.11, size.height * 0.5
    );
    horizontalPath.cubicTo(
      size.width * 0.11, size.height * 0.47,
      size.width * 0.14, size.height * 0.45,
      size.width * 0.17, size.height * 0.45
    );
    horizontalPath.lineTo(size.width * 0.91, size.height * 0.45);
    horizontalPath.cubicTo(
      size.width * 0.94, size.height * 0.45,
      size.width * 0.97, size.height * 0.47,
      size.width * 0.97, size.height * 0.5
    );
    horizontalPath.close();
    canvas.drawPath(horizontalPath, paint);

    // Arrow head
    final Path arrowPath = Path();
    arrowPath.moveTo(size.width * 0.53, size.height * 0.86);
    arrowPath.cubicTo(
      size.width * 0.54, size.height * 0.89,
      size.width * 0.54, size.height * 0.93,
      size.width * 0.51, size.height * 0.95
    );
    arrowPath.cubicTo(
      size.width * 0.49, size.height * 0.97,
      size.width * 0.45, size.height * 0.97,
      size.width * 0.43, size.height * 0.95
    );
    arrowPath.lineTo(size.width * 0.14, size.height * 0.66);
    arrowPath.cubicTo(
      size.width * 0.12, size.height * 0.64,
      size.width * 0.12, size.height * 0.61,
      size.width * 0.14, size.height * 0.59
    );
    arrowPath.lineTo(size.width * 0.43, size.height * 0.3);
    arrowPath.cubicTo(
      size.width * 0.45, size.height * 0.28,
      size.width * 0.49, size.height * 0.28,
      size.width * 0.51, size.height * 0.3
    );
    arrowPath.cubicTo(
      size.width * 0.54, size.height * 0.32,
      size.width * 0.54, size.height * 0.36,
      size.width * 0.53, size.height * 0.38
    );
    arrowPath.lineTo(size.width * 0.26, size.height * 0.5);
    arrowPath.lineTo(size.width * 0.53, size.height * 0.86);
    arrowPath.close();
    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class AppColors {
  // Main colors
  static const Color primary = Color(0xFFA57864);
  static const Color background = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1C1B1A);
  static const Color textSecondary = Color(0xFF4B4542);
  static const Color border = Color(0xFFE6DED3);

  // Logo gradient colors
  static const Color logoGradient1 = Color(0xFFA67C52);
  static const Color logoGradient2 = Color(0xFFF0C89E);
  static const Color logoGradient3 = Color(0xFFE3B788);

  // Social button colors
  static const Color facebookBlue = Color(0xFF2AA4F4);
  static const Color facebookBlueDark = Color(0xFF007AD9);
  static const Color googleRed = Color(0xFFEB4335);
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color appleBlack = Color(0xFF000000);
}