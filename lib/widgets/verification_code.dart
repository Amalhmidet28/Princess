import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationCodeInput extends StatelessWidget {
  final List<String> codeDigits;
  final int activeDigitIndex;
  final Function(int) onDigitTap;

  const VerificationCodeInput({
    Key? key,
    required this.codeDigits,
    required this.activeDigitIndex,
    required this.onDigitTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () => onDigitTap(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 61,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE6DED3),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                codeDigits[index],
                style: GoogleFonts.figtree(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1C1B1A),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}