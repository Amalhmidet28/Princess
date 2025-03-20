import 'dart:io';
import 'package:cutfx/bloc/login/login_bloc.dart';
import 'package:cutfx/screens/login/email_login_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginOptionScreen extends StatelessWidget {
  const LoginOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 244, 243),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),

                // 🔹 Logo & Title
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'asset/artwork.png', // Ensure this path is correct
                        width: 300,
                        height: 150,
                        fit: BoxFit.contain, // Keeps the image ratio
                      ),
                      const SizedBox(height: 20),
                      const AppLogo(textSize: 30, width: 15, height: 15),
                      const SizedBox(height: 10),
                      Text(
                  "Let's you in",
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'RecklessNeue', // Custom Font
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 🔹 Description
                Text(
                  AppLocalizations.of(context)!
                      .findAndBookHairCutMassageSpaWaxingColoringServicesAnytime,
                  style: kLightWhiteTextStyle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // 🔹 Apple Sign-In (Only for iOS)
                if (Platform.isIOS)
                  IconWithTextButton(
                    image: AssetRes.icApple,
                    text: AppLocalizations.of(context)!.signInWithApple,
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginClickEvent(0));
                    },
                  ),

                const SizedBox(height: 20),

                // 🔹 Google Sign-In
                IconWithTextButton(
                  image: AssetRes.icGoogle,
                  text: AppLocalizations.of(context)!.signInWithGoogle,
                  iconPadding: 8,
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginClickEvent(1));
                  },
                ),

                const SizedBox(height: 20),

                // 🔹 Divider (OR)
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔹 Sign in with password
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B6A5A), // Marron
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailLoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign in with password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconWithTextButton extends StatelessWidget {
  final String image;
  final String text;
  final double? iconPadding;
  final Function()? onPressed;

  const IconWithTextButton({
    super.key,
    required this.image,
    required this.text,
    this.iconPadding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: TextButton(
        style: kButtonWhiteStyle,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align icon & text
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: iconPadding ?? 0),
              child: Image.asset(image, fit: BoxFit.contain), // Fixed Image Fit
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: kBlackButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
