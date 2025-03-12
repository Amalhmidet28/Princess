import 'dart:async';
import 'package:cutfx/widgets/custom_key.dart';
import 'package:cutfx/widgets/statu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key, required String method}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // State for verification code
  final List<String> _codeDigits = ['', '', '', ''];
  int _activeDigitIndex = 0; // Index of the currently active input field

  // Timer state
  int _remainingSeconds = 55;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _onKeyPressed(String value) {
    if (value == 'delete') {
      // Handle backspace
      setState(() {
        if (_activeDigitIndex > 0 && _codeDigits[_activeDigitIndex].isEmpty) {
          _activeDigitIndex--;
          _codeDigits[_activeDigitIndex] = '';
        } else if (_activeDigitIndex < _codeDigits.length && _codeDigits[_activeDigitIndex].isNotEmpty) {
          _codeDigits[_activeDigitIndex] = '';
        }
      });
    } else {
      // Handle number input
      setState(() {
        if (_activeDigitIndex < _codeDigits.length) {
          _codeDigits[_activeDigitIndex] = value;
          if (_activeDigitIndex < _codeDigits.length - 1) {
            _activeDigitIndex++;
          }
        }
      });
    }
  }

  bool get _isCodeComplete {
    return !_codeDigits.contains('');
  }

  void _verifyCode() {
    if (_isCodeComplete) {
      // Implement verification logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verifying code...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              // Status Bar
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: StatusBarWidget(),
              ),

              // Main Content
              Positioned.fill(
                top: 44, // Height of status bar
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                        child: Column(
                          children: [
                            // Header with back button and title
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    alignment: Alignment.center,
                                    child: SvgPicture.string(
                                      '''
                                      <svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M23.3333 14.3203C23.3333 14.7633 23.0041 15.1294 22.577 15.1873L22.4583 15.1953L4.95825 15.1953C4.475 15.1953 4.08325 14.8036 4.08325 14.3203C4.08325 13.8773 4.41243 13.5112 4.83952 13.4533L4.95825 13.4453L22.4583 13.4453C22.9415 13.4453 23.3333 13.8371 23.3333 14.3203Z" fill="#1C1B1A"/>
                                        <path d="M12.6338 20.7286C12.9762 21.0696 12.9774 21.6236 12.6365 21.9661C12.3265 22.2774 11.8404 22.3067 11.4974 22.0532L11.399 21.9687L4.3407 14.9407C4.02846 14.6298 4.00005 14.142 4.2555 13.7989L4.34065 13.7007L11.399 6.67151C11.7414 6.33051 12.2954 6.33165 12.6364 6.67407C12.9464 6.98535 12.9737 7.47152 12.7188 7.81354L12.6339 7.9115L6.19848 14.321L12.6338 20.7286Z" fill="#1C1B1A"/>
                                      </svg>
                                      ''',
                                      width: 28,
                                      height: 28,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Forgot Password',
                                  style: GoogleFonts.figtree(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1C1B1A),
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 60),

                            // Content Section
                            Expanded(
                              child: Column(
                                children: [
                                  // Message
                                  Text(
                                    'Code has been send to +974 00 *** **0',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.figtree(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1C1B1A),
                                      height: 1.4,
                                      letterSpacing: 0.2,
                                    ),
                                  ),

                                  const SizedBox(height: 60),

                                  // Verification Code Input
                                  Container(
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(_codeDigits.length, (index) {
      bool isActive = index == _activeDigitIndex;
      return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Color.fromARGB(210, 243, 220, 207) : Colors.transparent, // Marron foncé si actif
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? Color.fromARGB(255, 209, 181, 160) : Colors.grey.shade400, // Bordure adaptée
            width: 2,
          ),
        ),
        child: Text(
          _codeDigits[index],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black, // Texte blanc si actif
          ),
        ),
      );
    }),
  ),
),

                                  // Resend Text with Timer
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: GoogleFonts.figtree(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1C1B1A),
                                        height: 1.4,
                                        letterSpacing: 0.2,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Resend code in '),
                                        TextSpan(
                                          text: '$_remainingSeconds',
                                          style: const TextStyle(
                                            color: Color(0xFFA57864),
                                          ),
                                        ),
                                        const TextSpan(text: 's'),
                                      ],
                                    ),
                                  ),

                                  const Spacer(),

                                  // Verify Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: _isCodeComplete ? _verifyCode : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFD1C7BA),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        elevation: 0,
                                        disabledBackgroundColor: const Color(0xFF9B6A5A),
                                        disabledForegroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        'Verify',
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Keyboard
                    CustomKeypad(onKeyPressed: _onKeyPressed),
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