import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCategoryItem extends StatelessWidget {
  final String iconUrl;
  final String label;

  const ServiceCategoryItem({
    Key? key,
    required this.iconUrl,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon container
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFFB9400).withOpacity(0.12),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Image.network(
              iconUrl,
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Label
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.figtree(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1C1B1A),
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}