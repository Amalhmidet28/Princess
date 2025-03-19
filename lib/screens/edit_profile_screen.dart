import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../bloc/edit/edit_profile_bloc.dart';
import '../../utils/color_res.dart';
import '../../utils/style_res.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.editProfile),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            EditProfileBloc editProfileBloc = context.read<EditProfileBloc>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: "Full Name",
                      controller: editProfileBloc.fullNameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Username",
                      controller: editProfileBloc.nickNameController,
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    DatePickerField(editProfileBloc: editProfileBloc),
                    
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Email",
                      controller: editProfileBloc.emailController,
                    ),
                    const SizedBox(height: 16),
                    
                    const SizedBox(height: 16),
                    PhoneInputField(editProfileBloc: editProfileBloc),
                    const SizedBox(height: 16),
                    CountryDropdownField(editProfileBloc: editProfileBloc),
                  
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Address",
                      controller: editProfileBloc.addressController,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5E3B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          editProfileBloc.add(SubmitEditProfileEvent());
                        },
                        child: Text(
                          "Update",
                          style: kRegularWhiteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GenderDropdownField extends StatelessWidget {
  final EditProfileBloc editProfileBloc;
   GenderDropdownField({required this.editProfileBloc, Key? key}) : super(key: key);

  final List<String> genders = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: kLightWhiteTextStyle.copyWith(color: Colors.black, fontSize: 16)),
        const SizedBox(height: 5),
        DropdownButtonFormField(
          value: editProfileBloc.genderController.text.isEmpty ? null : editProfileBloc.genderController.text,
          items: genders.map((String gender) {
            return DropdownMenuItem(value: gender, child: Text(gender));
          }).toList(),
          onChanged: (value) {
            editProfileBloc.genderController.text = value as String;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorRes.smokeWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}


class CountryDropdownField extends StatelessWidget {
  final EditProfileBloc editProfileBloc;
  CountryDropdownField({required this.editProfileBloc, Key? key}) : super(key: key);

  final List<String> countries = ["USA", "Qatar","Tunisia", "Canada", "France", "Germany", "UK", "Spain", "Italy"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Country", style: kLightWhiteTextStyle.copyWith(color: Colors.black, fontSize: 16)),
        const SizedBox(height: 5),
        DropdownButtonFormField(
          value: editProfileBloc.countryController.text.isEmpty ? null : editProfileBloc.countryController.text,
          items: countries.map((String country) {
            return DropdownMenuItem(value: country, child: Text(country));
          }).toList(),
          onChanged: (value) {
            editProfileBloc.countryController.text = value as String;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorRes.smokeWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class DatePickerField extends StatelessWidget {
  final EditProfileBloc editProfileBloc;
  const DatePickerField({required this.editProfileBloc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date of Birth", style: kLightWhiteTextStyle.copyWith(color: Colors.black, fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          controller: editProfileBloc.dobController,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              editProfileBloc.dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorRes.smokeWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextField({required this.label, required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kLightWhiteTextStyle.copyWith(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorRes.smokeWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class PhoneInputField extends StatelessWidget {
  final EditProfileBloc editProfileBloc;

  const PhoneInputField({required this.editProfileBloc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: kLightWhiteTextStyle.copyWith(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InternationalPhoneNumberInput(
            textFieldController: editProfileBloc.phoneNumberController,
            onInputChanged: (PhoneNumber number) {
              editProfileBloc.phoneNumber = '${number.dialCode} ${number.parseNumber()}';
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              showFlags: true,
              useEmoji: true,
            ),
            textStyle: kRegularEmpressTextStyle.copyWith(color: ColorRes.charcoal50),
            cursorColor: ColorRes.themeColor,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(signed: false),
            inputDecoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }
}
