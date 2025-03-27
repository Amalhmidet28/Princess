import 'package:cutfx/screens/salon/salon_details_page.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SalonOnMapScreen extends StatelessWidget {
  const SalonOnMapScreen({Key? key, required void Function() onMenuClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LocationIllustration(),
              const SizedBox(height: 32),
              Text(
                'Enable Location',
                style: GoogleFonts.figtree(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFA57864),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We need location access to find the nearest barber/salon around you.',
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  color: const Color(0xFF1C1B1A),
                  height: 1.4,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigation vers FindNearbyScreen
                      Get.to(() => FindNearbyScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA57864),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Enable Location',
                      style: GoogleFonts.figtree(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF2F0E1),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.figtree(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFA57864),
                        height: 1.4,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04060F).withOpacity(0.05),
            blurRadius: 60,
          ),
        ],
      ),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF5ECE0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: const Color(0xFFB1A89D),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search',
                style: GoogleFonts.figtree(
                  fontSize: 14,
                  color: const Color(0xFFB1A89D),
                  letterSpacing: 0.2,
                  height: 1.4,
                ),
              ),
            ),
            Icon(
              Icons.filter_list,
              color: const Color(0xFFA57864),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class LocationIllustration extends StatelessWidget {
  const LocationIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(186, 180),
      painter: LocationIllustrationPainter(),
    );
  }
}

class LocationIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Main circle
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        const Color(0xFFA67C52),
        const Color(0xFFE3B788),
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawCircle(
      Offset(size.width * 0.51, size.height * 0.5),
      70.5,
      paint,
    );

    // Decorative circles
    paint.shader = null;
    paint.color = const Color(0xFFBAAA91);

    final circles = [
      [178.467, 27.5, 7.5],
      [20.0334, 10.0, 10.0],
      [10.0334, 133.0, 5.0],
      [165.533, 160.5, 2.5],
      [106.533, 4.5, 2.5],
      [62.5334, 176.5, 3.5],
      [122.033, 171.0, 1.0],
      [170.533, 110.5, 2.5],
      [1.03345, 75.0, 1.0],
    ];

    for (var circle in circles) {
      canvas.drawCircle(
        Offset(circle[0], circle[1]),
        circle[2],
        paint,
      );
    }

    // Checkmark icon
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.5;

    final path = Path()
      ..moveTo(size.width * 0.45, size.height * 0.5)
      ..lineTo(size.width * 0.48, size.height * 0.54)
      ..lineTo(size.width * 0.56, size.height * 0.46);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FindNearbyScreen extends StatelessWidget {
  const FindNearbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'images/Vector.png',
                fit: BoxFit.cover,
                color: Color(0xFFF5ECE0),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar section
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: CustomSearchBar(),
                ),
                // Circular layout with images
                Expanded(
                  child: SalonCircularLayout(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(4, 6, 15, 0.05),
            blurRadius: 60,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xFFF5ECE0),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.search, size: 20, color: Color(0xFFB1A89D)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search',
                style: TextStyle(
                  color: Color(0xFFB1A89D),
                  fontSize: 14,
                  fontFamily: 'Figtree',
                  letterSpacing: 0.2,
                ),
              ),
            ),
            Icon(Icons.filter_list, size: 20, color: Color(0xFFB1A89D)),
          ],
        ),
      ),
    );
  }
}

class SalonCircularLayout extends StatelessWidget {
  const SalonCircularLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var salonUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Center(
            child: Image.network(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/20d78227c8fcfa02ffdd77b88c8c7ea71b47f558?placeholderIfAbsent=true',
              width: 52,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/878a7b24f2d5e8c8619ec2536b4f8a25e581a7e7?placeholderIfAbsent=true',
                width: 52,
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/20d78227c8fcfa02ffdd77b88c8c7ea71b47f558?placeholderIfAbsent=true',
                width: 52,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const SizedBox(height: 49),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(165, 120, 100, 0.1),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 20,
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/fdcdf11021129ee364376372a66b4435e72d4e41?placeholderIfAbsent=true',
                    width: 52,
                    fit: BoxFit.contain,
                  ),
                ),
                CircleAvatar(
  radius: 50,
  backgroundImage: (salonUser?.profileImage ?? '').isNotEmpty
      ? NetworkImage(salonUser!.profileImage!)
      : const AssetImage("assets/default_profile.png") as ImageProvider,
),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/ab17b92c6eaf4ecd4cd00b7601d23c7a22824b41?placeholderIfAbsent=true',
                    width: 52,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: -8,
                  left: 0,
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/3cf427bbfd4911edbb088e05d161f8e6083825f1?placeholderIfAbsent=true',
                    width: 52,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 41,
            child: Image.network(
              'https://cdn.builder.io/api/v1/image/assets/TEMP/cf05a41821f85ade58a909c39afd12949a91d356?placeholderIfAbsent=true',
              width: 52,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

// class FindNearbySalonScreen extends StatefulWidget {
//   const FindNearbySalonScreen({Key? key}) : super(key: key);

//   @override
//   _FindNearbySalonScreenState createState() => _FindNearbySalonScreenState();
// }

// class _FindNearbySalonScreenState extends State<FindNearbySalonScreen> {
//   late GoogleMapController mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Map View
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(37.7749, -122.4194),
//               zoom: 14,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//           ),

          
          
//           // Selected Location Chip
//           Positioned(
//             right: 0,
//             top: 150,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//               margin: EdgeInsets.only(right: 18),
//               decoration: BoxDecoration(
//                 color: Color(0xFFA57864),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                   topRight: Radius.circular(100),
//                   bottomRight: Radius.circular(100),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Image.asset('assets/location_icon.png', width: 21, height: 21),
//                   SizedBox(width: 8),
//                   Text(
//                     'Salon Name',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'Figtree',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Bottom Sheet
//           DraggableScrollableSheet(
//             initialChildSize: 0.35,
//             minChildSize: 0.35,
//             maxChildSize: 0.8,
//             builder: (context, scrollController) {
//               var onMenuClick;
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                   border: Border.all(
//                     color: Color(0xFFF5ECE0),
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     // Handle
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Container(
//                         width: 38,
//                         height: 3,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFD1C7BA),
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                       ),
//                     ),

//                     // Details Title
//                     Padding(
//                       padding: const EdgeInsets.only(top: 24),
//                       child: Text(
//                         'Details',
//                         style: TextStyle(
//                           color: Color(0xFF1C1B1A),
//                           fontSize: 24,
//                           fontWeight: FontWeight.w700,
//                           fontFamily: 'Figtree',
//                         ),
//                       ),
//                     ),

//                     // Salon Details Card
//                     Padding(
//                       padding: const EdgeInsets.all(24),
//                       child:SalonOnMapScreen(onMenuClick: onMenuClick),
//                     ),

//                     // Get Direction Button
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24),
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFFA57864),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 18),
//                           elevation: 4,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.shopping_bag_outlined, size: 20),
//                             SizedBox(width: 16),
//                             Text(
//                               'Get Direction',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: 'Figtree',
//                                 letterSpacing: 0.2,
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Icon(Icons.arrow_forward, size: 20),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }