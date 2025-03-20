import 'package:cutfx/bloc/notificationsettings/notification_settings_bloc.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationSettingsBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [ Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: ColorRes.black,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      'Notification',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1C1B1A),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Notification settings list
              Expanded(
                child: BlocBuilder<NotificationSettingsBloc, NotificationSettingsState>(
                  builder: (context, state) {
                    return ListView(
                      padding: const EdgeInsets.all(24.0),
                      children: [
                        _buildSettingItem(context, 'General Notification', state.settings.generalNotification, 'generalNotification'),
                        _buildSettingItem(context, 'Sound', state.settings.sound, 'sound'),
                        _buildSettingItem(context, 'Vibrate', state.settings.vibrate, 'vibrate'),
                        _buildSettingItem(context, 'Special Offers', state.settings.specialOffers, 'specialOffers'),
                        _buildSettingItem(context, 'Promo & Discount', state.settings.promoDiscount, 'promoDiscount'),
                        _buildSettingItem(context, 'Payments', state.settings.payments, 'payments'),
                        _buildSettingItem(context, 'App Updates', state.settings.appUpdates, 'appUpdates'),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildSettingItem(BuildContext context, String title, bool value, String settingKey) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Figtree',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2E2B28),
              letterSpacing: 0.2,
            ),
          ),
          ToggleSwitch(
            value: value,
            onToggle: (newValue) {
              context.read<NotificationSettingsBloc>().add(ToggleSetting(settingKey: settingKey, value: newValue));
            },
          ),
        ],
      ),
    );
  }
}

class ToggleSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onToggle;

  const ToggleSwitch({
    Key? key,
    required this.value,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: value ? const Color(0xFFA57864) : const Color(0xFFE6DED3),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 28,
        height: 28,
        color: Colors.transparent,
        child: CustomPaint(
          painter: BackArrowPainter(),
        ),
      ),
    );
  }
}

class BackArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1C1B1A)
      ..style = PaintingStyle.fill;

    // Horizontal line
    final path1 = Path()
      ..moveTo(size.width, size.height / 2)
      ..lineTo(0, size.height / 2)
      ..close();

    // Arrow head
    final path2 = Path()
      ..moveTo(size.width * 0.4, size.height * 0.2)
      ..lineTo(0, size.height / 2)
      ..lineTo(size.width * 0.4, size.height * 0.8)
      ..close();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class SignalIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw 4 bars of signal
    final barWidth = size.width / 5;
    final spacing = barWidth / 4;
    final totalWidth = (barWidth * 4) + (spacing * 3);
    final startX = (size.width - totalWidth) / 2;

    for (int i = 0; i < 4; i++) {
      final height = size.height * ((i + 1) / 4);
      final x = startX + (i * (barWidth + spacing));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, size.height - height, barWidth, height),
          const Radius.circular(1),
        ),
        paint,
      );
    }
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

    final center = Offset(size.width / 2, size.height);

    // Draw 3 arcs for wifi
    for (int i = 1; i <= 3; i++) {
      final radius = i * (size.width / 3);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        3.14, // pi
        3.14, // pi
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}