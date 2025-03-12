import 'package:flutter/material.dart';

class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
    ));
  }
}

class SignalBarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw 4 signal bars with different heights
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 8, 3, 8),
      paint,
    );

    canvas.drawRect(
      Rect.fromLTWH(5, size.height - 6, 3, 6),
      paint,
    );

    canvas.drawRect(
      Rect.fromLTWH(10, size.height - 4, 3, 4),
      paint,
    );

    canvas.drawRect(
      Rect.fromLTWH(15, size.height - 2, 3, 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WifiIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw WiFi arcs
    final center = Offset(size.width / 2, size.height);

    // Outer arc
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 16, height: 16),
      3.14, // pi
      3.14, // pi
      false,
      paint,
    );

    // Middle arc
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 12, height: 12),
      3.14, // pi
      3.14, // pi
      false,
      paint,
    );

    // Inner arc
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 8, height: 8),
      3.14, // pi
      3.14, // pi
      false,
      paint,
    );

    // Center dot
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, 1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}