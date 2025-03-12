import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomKeypad({
    Key? key,
    required this.onKeyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // First row: 1, 2, 3
          _buildKeypadRow(['1', '2', '3']),
          const SizedBox(height: 8),

          // Second row: 4, 5, 6
          _buildKeypadRow(['4', '5', '6']),
          const SizedBox(height: 8),

          // Third row: 7, 8, 9
          _buildKeypadRow(['7', '8', '9']),
          const SizedBox(height: 8),

          // Fourth row: *, 0, delete
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildKey('*'),
              const SizedBox(width: 8),
              _buildKey('0'),
              const SizedBox(width: 8),
              _buildDeleteKey(),
            ],
          ),

          // Home indicator
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 9),
            width: 134,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) {
        return Expanded(
          child: _buildKey(key),
        );
      }).toList().separated(const SizedBox(width: 8)),
    );
  }

  Widget _buildKey(String value) {
    return GestureDetector(
      onTap: () => onKeyPressed(value),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: GoogleFonts.aBeeZee(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1C1B1A),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteKey() {
    return GestureDetector(
      onTap: () => onKeyPressed('delete'),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: SvgPicture.string(
          '''
          <svg width="29" height="28" viewBox="0 0 29 28" fill="none" xmlns="http://www.w3.org/2000/svg">
            <g clip-path="url(#clip0_59_1983)">
              <path d="M23.6666 7C23.976 7 24.2727 7.12292 24.4915 7.34171C24.7103 7.5605 24.8332 7.85725 24.8332 8.16667V19.8333C24.8332 20.1428 24.7103 20.4395 24.4915 20.6583C24.2727 20.8771 23.976 21 23.6666 21H10.8332L4.99989 15.1667C4.71291 14.8458 4.55426 14.4305 4.55426 14C4.55426 13.5695 4.71291 13.1542 4.99989 12.8333L10.8332 7H23.6666Z" stroke="#2C3E50" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
              <path d="M19 11.6665L14.3333 16.3332M14.3333 11.6665L19 16.3332L14.3333 11.6665Z" stroke="#2C3E50" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </g>
            <defs>
              <clipPath id="clip0_59_1983">
                <rect width="28" height="28" fill="white" transform="translate(0.333313)"/>
              </clipPath>
            </defs>
          </svg>
          ''',
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}

// Extension to add separators between widgets in a list
extension ListWidgetExtension on List<Widget> {
  List<Widget> separated(Widget separator) {
    if (length <= 1) return this;

    final result = <Widget>[];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}