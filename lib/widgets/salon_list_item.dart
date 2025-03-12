import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalonListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final bool isBookmarked;

  const SalonListItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    this.isBookmarked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04060F).withOpacity(0.05),
            blurRadius: 60,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Salon image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),

          // Salon details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and bookmark
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.figtree(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1C1B1A),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      // Bookmark icon would go here
                    ),
                  ],
                ),

                // Address
                const SizedBox(height: 8),
                Text(
                  address,
                  style: GoogleFonts.figtree(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6A625E),
                    letterSpacing: 0.2,
                  ),
                ),

                // Distance and rating
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Distance
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          // Location icon would go here
                        ),
                        const SizedBox(width: 6),
                        Text(
                          distance,
                          style: GoogleFonts.figtree(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2E2B28),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),

                    // Rating
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          // Star icon would go here
                        ),
                        const SizedBox(width: 6),
                        Text(
                          rating,
                          style: GoogleFonts.figtree(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2E2B28),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}