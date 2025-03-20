import 'package:cutfx/screens/profile/chnage_password_bottom.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
           
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildSecurityOptions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  Widget _buildHeader() {
    return Row(
      children: [const SizedBox(width: 10),
       Row(
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
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Security',
            style: TextStyle(
              color: Color(0xFF1C1B1A),
              fontFamily: 'Figtree',
              fontSize: 24,
              
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
        
      ],
    );
  }

  Widget _buildSecurityOptions() {
    return Column(
      children: [
        _buildSecurityOption('Remember me'),
        const SizedBox(height: 36),
        _buildSecurityOption('Face ID'),
        const SizedBox(height: 36),
        _buildSecurityOption('Biometric ID'),
        const SizedBox(height: 36),
        _buildChangePasswordButton(),
      ],
    );
  }

  Widget _buildSecurityOption(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xFF2E2B28),
              fontFamily: 'Figtree',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(width: 20),
        ToggleSwitch(
          initialValue: true,
          activeColor: Color(0xFFA57864),
        ),
      ],
    );
  }

  Widget _buildChangePasswordButton() {
  return GestureDetector(
    onTap: () {
      Get.bottomSheet(
        const ChangePasswordBottomSheet(),
        isScrollControlled: true,
        ignoreSafeArea: false,
      );
    },
    child: Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xFFF2F0E1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          'Change Password',
          style: TextStyle(
            color: Color(0xFFA57864),
            fontFamily: 'Figtree',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.4,
            letterSpacing: 0.2,
          ),
        ),
      ),
    ),
  );
}

}

class ToggleSwitch extends StatefulWidget {
  final bool initialValue;
  final Color activeColor;
  final Function(bool)? onChanged;

  const ToggleSwitch({
    Key? key,
    this.initialValue = false,
    this.activeColor = Colors.blue,
    this.onChanged,
  }) : super(key: key);

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> with SingleTickerProviderStateMixin {
  late bool _isOn;
  late AnimationController _animationController;
  late Animation<Offset> _toggleAnimation;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialValue;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _toggleAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(1, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (_isOn) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOn = !_isOn;
      if (_isOn) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }

      if (widget.onChanged != null) {
        widget.onChanged!(_isOn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color: _isOn ? widget.activeColor : Colors.grey.shade300,
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  left: _isOn ? 20 : 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: _isOn ? widget.activeColor : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}