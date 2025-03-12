import 'dart:io';

import 'package:cutfx/bloc/login/login_bloc.dart';
import 'package:cutfx/screens/login/email_login_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Logo
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'asset/artwork.png', // Remplacez par le chemin du logo approprié
                        width: 380,
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Let's you in",
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily:
                              'RecklessNeue', // Nom de la famille de police définie
                          fontWeight:
                              FontWeight.bold, // Utilisation de la version bold
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.signInToContinue,
                  style: kSemiBoldWhiteTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!
                      .findAndBookHairCutMassageSpaWaxingColoringServicesAnytime,
                  style: kLightWhiteTextStyle,
                ),
                Visibility(
                  visible: Platform.isIOS,
                  child: IconWithTextButton(
                    image: AssetRes.icApple,
                    text: AppLocalizations.of(context)!.signInWithApple,
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginClickEvent(0));
                    },
                  ),
                ),
                // Continue with Facebook
                IconWithTextButton(
                  image: 'asset/Facebook.png',
                  text: 'Continue with Facebook',
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginClickEvent(0));
                  },
                ),

                const SizedBox(height: 20),

                // Continue with Google
                IconWithTextButton(
                  image: AssetRes.icGoogle,
                  text: 'Continue with Google',
                  iconPadding: 8,
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginClickEvent(1));
                  },
                ),

                const SizedBox(height: 20),

                // Continue with Apple (only for iOS)
                if (Platform.isIOS)
                  IconWithTextButton(
                    image: 'asset/apple.png',
                    text: 'Continue with Apple',
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginClickEvent(2));
                    },
                  ),
                Text(
                  AppLocalizations.of(context)!.byContinuingWithAnyOptions,
                  style: kLightWhiteTextStyle,
                ),

                const SizedBox(height: 20),
                Row(
                  children: const <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Sign in with password
                SizedBox(
                  width: 380,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90,
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: iconPadding ?? 0),
              child: Image(image: AssetImage(image)),
            ),
            Center(
              child: Text(
                text,
                style: kBlackButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
