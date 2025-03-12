import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactOption extends StatelessWidget {
  final IconData icon;
  final String contactType;
  final String contactValue;
  final bool isSelected;

  const ContactOption({
    Key? key,
    required this.icon,
    required this.contactType,
    required this.contactValue,
    this.isSelected = false, required void Function() onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(color: const Color(0xFFA57864), width: 2)
            : null,
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: const Color(0x1A000000),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        children: [
          _buildIconContainer(),
          const SizedBox(width: 20),
          _buildContactDetails(),
        ],
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F0E1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        icon,
        size: 32,
        color: const Color(0xFF1C1B1A),
      ),
    );
  }

  Widget _buildContactDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contactType,
            style: GoogleFonts.figtree(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6A625E),
              height: 1.4,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            contactValue,
            style: GoogleFonts.figtree(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              height: 1.4,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}