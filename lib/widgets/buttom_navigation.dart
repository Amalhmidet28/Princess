import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Navigation items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem('Home', true),
                _buildNavItem('Explore', false),
                _buildNavItem('My Booking', false),
                _buildNavItem('Profile', false),
              ],
            ),
          ),

          // Home indicator
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 21, 80, 8),
            child: Container(
              width: 134,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFD1C7BA),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, bool isSelected) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            // Icon would go here
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.figtree(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFFA57864) : const Color(0xFF8B8377),
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}