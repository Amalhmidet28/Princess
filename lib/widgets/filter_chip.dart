import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomFilterChip({
    Key? key,
    required this.label,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA57864) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFA57864), width: 2),
        ),
        child: Text(
          label,
          style: GoogleFonts.figtree(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFFA57864),
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}