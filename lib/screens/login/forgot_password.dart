import 'package:cutfx/screens/login/sms_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordBottomSheet> {
  String? _selectedMethod;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Forgot Password',
          style: GoogleFonts.figtree(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Select which contact details should we use to reset your password',
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            _buildOption(
                Icons.message_rounded, 'via SMS:', _phoneController, 'sms'),
            const SizedBox(height: 16),
            _buildOption(
                Icons.email_rounded, 'via Email:', _emailController, 'email'),
            const Spacer(),
            _buildContinueButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String type,
      TextEditingController controller, String method) {
    bool isSelected = _selectedMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0D6787)
                : Colors.grey.shade300, // Bleu foncé si sélectionné
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF40A1C1)
                        .withOpacity(0.5), // Bleu clair semi-transparent
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          Color.fromARGB(255, 245, 242, 235), // Cercle clair
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Color(0xFFA67C52),
                            Color(0xFFE3B788)
                          ], // Dégradé de l'icône
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: Icon(
                        icon,
                        size: 24,
                        color: Colors
                            .white, // L'icône doit être blanche pour appliquer le shader
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style: GoogleFonts.figtree(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: controller,
                        keyboardType: method == 'sms'
                            ? TextInputType.phone
                            : TextInputType.emailAddress,
                        inputFormatters: method == 'sms'
                            ? [
                                FilteringTextInputFormatter.digitsOnly
                              ] // Accepte uniquement des chiffres
                            : [],
                        decoration: InputDecoration(
                          hintText: method == 'sms'
                              ? 'Enter phone number'
                              : 'Enter email',
                          border: InputBorder.none,
                          errorText: method == 'sms' &&
                                  !_isValidPhone(controller.text)
                              ? ''
                              : null, // Affiche une erreur si le numéro est invalide
                        ),
                        onChanged: (value) {
                          setState(
                              () {}); // Met à jour l'état pour activer/désactiver le bouton
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    bool isFormValid = (_selectedMethod == 'sms' &&
            _phoneController.text.trim().isNotEmpty) ||
        (_selectedMethod == 'email' && _emailController.text.trim().isNotEmpty);

    return ElevatedButton(
      onPressed: isFormValid
          ? () {
              if (_selectedMethod == 'sms') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ForgotPasswordScreen(method: 'sms')),
                );
              } else if (_selectedMethod == 'email') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ForgotPasswordScreen(method: 'email')),
                );
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isFormValid
            ? const Color.fromARGB(255, 161, 118, 102)
            : Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        minimumSize: const Size(double.infinity, 56),
        elevation: 0,
      ),
      child: Text(
        'Continue',
        style: GoogleFonts.figtree(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

bool _isValidPhone(String phone) {
  RegExp regex = RegExp(r'^\d{8,15}$'); // Numéro de 8 à 15 chiffres
  return regex.hasMatch(phone);
}
