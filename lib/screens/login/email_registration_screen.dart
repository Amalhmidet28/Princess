import 'package:cutfx/bloc/registration/registration_bloc.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailRegistrationScreen extends StatelessWidget {
  const EmailRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF1C1B1A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 62),
                  Text(
                    AppLocalizations.of(context)!.emailRegistration,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      color: const Color(0xFF1C1B1A),
                    ),
                  ),
                  const SizedBox(height: 62),
                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      RegistrationBloc registrationBloc =
                          context.read<RegistrationBloc>();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.fullName,
                            controller: registrationBloc.fullNameTextController,
                          ),
                          const SizedBox(height: 20),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.emailAddress,
                            controller: registrationBloc.emailTextController,
                          ),
                          const SizedBox(height: 20),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.password,
                            controller: registrationBloc.passwordTextController,
                            isPassword: true,
                          ),
                          const SizedBox(height: 20),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.confirmPassword,
                            controller: registrationBloc.confirmPasswordTextController,
                            isPassword: true,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RegistrationBloc>()
                                  .add(ContinueRegistrationEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA57864),
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.continue_,
                              style: GoogleFonts.figtree(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextWithTextFieldSmokeWhiteWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  const TextWithTextFieldSmokeWhiteWidget({
    super.key,
    required this.title,
    this.isPassword,
    this.controller,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kLightWhiteTextStyle.copyWith(
            color: ColorRes.black,
            fontSize: 16,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          height: 55,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: InputBorder.none),
            style: kRegularTextStyle.copyWith(
              color: ColorRes.charcoal50,
            ),
            keyboardType: textInputType,
            obscureText: isPassword ?? false,
            enableSuggestions: isPassword != null ? !isPassword! : true,
            autocorrect: isPassword != null ? !isPassword! : true,
          ),
        ),
      ],
    );
  }
}
