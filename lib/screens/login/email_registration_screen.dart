import 'package:cutfx/bloc/registration/registration_bloc.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class EmailRegistrationScreen extends StatefulWidget {
  const EmailRegistrationScreen({super.key});

  @override
  State<EmailRegistrationScreen> createState() =>
      _EmailRegistrationScreenState();
}

class _EmailRegistrationScreenState extends State<EmailRegistrationScreen> {
  bool isPasswordVisible = false;
  bool rememberMe = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  // Handle Google SignIn
  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Handle sign-in result (user info, etc.)
        print("Google User: ${googleUser.displayName}");
      }
    } catch (error) {
      print("Google Sign-In error: $error");
    }
  }

  // Handle Apple SignIn
  /*Future<void> _handleAppleSignIn() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScope.email,
          AppleIDAuthorizationScope.fullName,
        ],
      );
      print("Apple User: ${appleCredential.email}");
    } catch (error) {
      print("Apple Sign-In error: $error");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Back Button
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF1C1B1A),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🔹 Title
                  Text(
                    AppLocalizations.of(context)!.emailRegistration,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      color: const Color.fromARGB(255, 9, 8, 7),
                    ),
                  ),

                  const SizedBox(height: 40),

                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      RegistrationBloc registrationBloc =
                          context.read<RegistrationBloc>();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 🔹 Email Input
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.emailAddress,
                            controller: registrationBloc.emailTextController,
                            icon: Icons.email_outlined, // Added email icon
                          ),

                          const SizedBox(height: 20),

                          // 🔹 Password Input with Visibility Toggle
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.password,
                            controller: registrationBloc.passwordTextController,
                            isPassword: true,
                            icon: Icons.lock_outline, // Added password icon
                            isPasswordVisible: isPasswordVisible,
                            onVisibilityToggle: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),

                          const SizedBox(height: 20),

                          // 🔹 Remember Me Section
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Center horizontally
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: rememberMe,
                                activeColor: const Color(0xFFA57864),
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.rememberMe,
                                style: GoogleFonts.figtree(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorRes.black,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // 🔹 Continue Button
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RegistrationBloc>()
                                  .add(ContinueRegistrationEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA57864),
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.continue_,
                              style: GoogleFonts.figtree(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // 🔹 Google Login Button
                          const SizedBox(height: 20),
                          // 🔹 Google Login Button with Google Logo
const SizedBox(height: 20),
ElevatedButton(
  onPressed: _handleGoogleSignIn,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100), // Rounded button
    ),
  ),
  child: Center(
    child: Container(
      height: 40, 
      width: 40,  
      decoration: BoxDecoration(
        shape: BoxShape.circle, 
        image: DecorationImage(
          image: AssetImage('asset/Googlelogo.png'), 
          fit: BoxFit.fill, 
        ),
      ),
    ),
  ),
),



                          // 🔹 Apple Login Button
                          /*const SizedBox(height: 20),
                          SignInWithAppleButton(
                            onPressed: _handleAppleSignIn,
                            style: SignInWithAppleButtonStyle.black,
                          ),*/
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on AppLocalizations {
  // ignore: unused_element
  String get rememberMe => rememberMe;
}

class TextWithTextFieldSmokeWhiteWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final IconData? icon;
  final bool? isPasswordVisible;
  final VoidCallback? onVisibilityToggle;

  const TextWithTextFieldSmokeWhiteWidget({
    super.key,
    required this.title,
    this.isPassword,
    this.controller,
    this.textInputType = TextInputType.text,
    this.icon,
    this.isPasswordVisible,
    this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kLightWhiteTextStyle.copyWith(
            color: ColorRes.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              if (icon != null)
                Icon(icon, color: ColorRes.charcoal50), // 🔹 Input Icon

              const SizedBox(width: 10),

              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: kRegularTextStyle.copyWith(
                    color: ColorRes.charcoal50,
                  ),
                  keyboardType: textInputType,
                  obscureText: isPassword ?? false
                      ? !(isPasswordVisible ?? false)
                      : false,
                  enableSuggestions: isPassword != null ? !isPassword! : true,
                  autocorrect: isPassword != null ? !isPassword! : true,
                ),
              ),

              // 🔹 Password Visibility Toggle Button
              if (isPassword ?? false)
                GestureDetector(
                  onTap: onVisibilityToggle,
                  child: Icon(
                    isPasswordVisible!
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: ColorRes.charcoal50,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
