import 'package:cutfx/bloc/emaillogin/email_login_bloc.dart';
import 'package:cutfx/screens/constants/assets.dart';
import 'package:cutfx/screens/login/email_registration_screen.dart';
import 'package:cutfx/screens/login/forgot_password.dart';
import 'package:cutfx/screens/login/login_option_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);
  
  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailLoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 428),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBackButton(context),
                        _buildTitle(),
                        const SizedBox(height: 24),
                        _buildLoginForm(context),
                        const SizedBox(height: 24),
                        _buildSocialLogin(),
                        const SizedBox(height: 24),
                        _buildSignUpPrompt(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: SvgPicture.string(SvgAssets.backArrow, width: 28, height: 28),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontFamily: 'RecklessNeue', fontSize: 36, fontWeight: FontWeight.w700, color: const Color(0xFF1C1B1A)),
        children: const [
          TextSpan(text: 'Login to your'),
          TextSpan(text: '\nAccount'),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        CustomTextField(hintText: 'Email', leadingSvg: SvgAssets.emailIcon),
        const SizedBox(height: 24),
        CustomTextField(
          hintText: 'Password',
          leadingSvg: SvgAssets.lockIcon,
          obscureText: !_isPasswordVisible,
          trailingSvg: _isPasswordVisible ? SvgAssets.eyeIcon : SvgAssets.eyeOffIcon,
          onTrailingIconTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        const SizedBox(height: 24),
        _buildSignInButton(context),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () => Get.bottomSheet(const ForgotPasswordBottomSheet()),
          child: const Text('Forgot the password?', style: TextStyle(color: Colors.brown)),
        ),
      ],
    );
  }
  

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.read<EmailLoginBloc>().add(ContinueLoginEvent()),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD1C7BA),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: const Text('Sign in', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider(color: Colors.grey)),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('or continue with')),
            Expanded(child: Divider(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialLoginButton(svgIcon: SvgAssets.facebookIcon, onPressed: () {}),
            SocialLoginButton(svgIcon: SvgAssets.googleIcon, onPressed: () {}),
            SocialLoginButton(svgIcon: SvgAssets.appleIcon, onPressed: () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        GestureDetector(
          onTap: () => Get.to(() => const EmailRegistrationScreen()),
          child: const Text(
            ' Sign up', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFA57864)),
          ),)
      ],
    );
  }
}

/// Constants for SVG assets used in the app
class SocialLoginButton extends StatelessWidget {
  final String svgIcon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    Key? key,
    required this.svgIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE6DED3),
            width: 1,
          ),
        ),
        child: SvgPicture.string(
          svgIcon,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String leadingSvg;
  final String? trailingSvg;
  final bool obscureText;
  final VoidCallback? onTrailingIconTap;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.leadingSvg,
    this.trailingSvg,
    this.obscureText = false,
    this.onTrailingIconTap,
    this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SvgPicture.string(
            leadingSvg,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontFamily: 'Figtree',
                fontSize: 14,
                color: Color(0xFF8B8377),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Figtree',
                  fontSize: 14,
                  color: Color(0xFF8B8377),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (trailingSvg != null)
            GestureDetector(
              onTap: onTrailingIconTap,
              child: SvgPicture.string(
                trailingSvg!,
                width: 20,
                height: 20,
              ),
            ),
        ],
      ),
    );
  }
}
