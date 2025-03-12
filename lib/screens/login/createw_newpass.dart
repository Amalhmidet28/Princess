import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  bool _rememberMe = true;
  
  var auto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 428),
          margin: EdgeInsets.symmetric(horizontal: auto),
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: GoogleFonts.figtree(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          Row(
            children: [
              _buildStatusIcons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcons() {
    return Row(
      children: [
        _buildSignalStrengthIcon(),
        const SizedBox(width: 5),
        _buildWifiIcon(),
        const SizedBox(width: 5),
        _buildBatteryIcon(),
      ],
    );
  }

  Widget _buildSignalStrengthIcon() {
    return Row(
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.only(right: 1),
          width: 3,
          height: 8 + index * 2,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }

  Widget _buildWifiIcon() {
    return const Icon(
      Icons.wifi,
      size: 16,
      color: Colors.black,
    );
  }

  Widget _buildBatteryIcon() {
    return Container(
      width: 24,
      height: 12,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Container(
            width: 2,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSubtitle(),
          const SizedBox(height: 24),
          _buildPasswordField(
            isObscured: _obscurePassword1,
            onToggleVisibility: () {
              setState(() {
                _obscurePassword1 = !_obscurePassword1;
              });
            },
          ),
          const SizedBox(height: 24),
          _buildPasswordField(
            isObscured: _obscurePassword2,
            onToggleVisibility: () {
              setState(() {
                _obscurePassword2 = !_obscurePassword2;
              });
            },
          ),
          const SizedBox(height: 24),
          _buildRememberMe(),
          const Spacer(),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: 28,
            height: 28,
            child: _buildBackArrowIcon(),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'Create New Password',
          style: GoogleFonts.figtree(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1C1B1A),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Create Your New Password',
      style: GoogleFonts.figtree(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1C1B1A),
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildPasswordField({
    required bool isObscured,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildLockIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '●●●●●●●●●●●●',
              style: GoogleFonts.figtree(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1C1B1A),
                letterSpacing: 0.2,
              ),
            ),
          ),
          GestureDetector(
            onTap: onToggleVisibility,
            child: _buildHideIcon(),
          ),
        ],
      ),
    );
  }

  Widget _buildRememberMe() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rememberMe = !_rememberMe;
        });
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _rememberMe ? const Color(0xFFA57864) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: _rememberMe
                  ? null
                  : Border.all(color: const Color(0xFF1C1B1A), width: 1),
            ),
            child: _rememberMe
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            'Remember me',
            style: GoogleFonts.figtree(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1C1B1A),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA57864),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 4,
          shadowColor: const Color(0x403E2B23),
        ),
        child: Text(
          'Continue',
          style: GoogleFonts.figtree(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  Widget _buildBackArrowIcon() {
    return CustomPaint(
      size: const Size(28, 28),
      painter: BackArrowPainter(),
    );
  }

  Widget _buildLockIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: LockIconPainter(),
    );
  }

  Widget _buildHideIcon() {
    return CustomPaint(
      size: const Size(20, 20),
      painter: HideIconPainter(),
    );
  }
}

class BackArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1C1B1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw horizontal line
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.5),
      Offset(size.width * 0.9, size.height * 0.5),
      paint,
    );

    // Draw arrow head
    final path = Path()
      ..moveTo(size.width * 0.45, size.height * 0.25)
      ..lineTo(size.width * 0.15, size.height * 0.5)
      ..lineTo(size.width * 0.45, size.height * 0.75);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LockIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1C1B1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw lock body
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.45, size.width * 0.6, size.height * 0.5),
      Radius.circular(size.width * 0.1),
    );
    canvas.drawRRect(bodyRect, paint);

    // Draw lock shackle
    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.45)
      ..lineTo(size.width * 0.3, size.height * 0.3)
      ..arcToPoint(
        Offset(size.width * 0.7, size.height * 0.3),
        radius: Radius.circular(size.width * 0.2),
        clockwise: true,
      )
      ..lineTo(size.width * 0.7, size.height * 0.45);
    canvas.drawPath(path, paint);

    // Draw keyhole
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.65),
      size.width * 0.08,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HideIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1C1B1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw eye
    final eyePath = Path();
    eyePath.moveTo(size.width * 0.1, size.height * 0.5);
    eyePath.cubicTo(
      size.width * 0.25, size.height * 0.25,
      size.width * 0.75, size.height * 0.25,
      size.width * 0.9, size.height * 0.5,
    );
    eyePath.cubicTo(
      size.width * 0.75, size.height * 0.75,
      size.width * 0.25, size.height * 0.75,
      size.width * 0.1, size.height * 0.5,
    );
    canvas.drawPath(eyePath, paint);

    // Draw pupil
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.1,
      paint,
    );

    // Draw slash
    canvas.drawLine(
      Offset(size.width * 0.15, size.height * 0.15),
      Offset(size.width * 0.85, size.height * 0.85),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}