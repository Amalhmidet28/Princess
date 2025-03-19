import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<FetchUserProfileEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      SalonUser? salonUser = sharePref.getSalonUser();
      if (salonUser != null) {
        fullNameController.text = salonUser.data?.fullname ?? '';
        nickNameController.text = salonUser.data?.nickname ?? '';
        dobController.text = salonUser.data?.dob ?? '';
        emailController.text = salonUser.data?.email ?? '';
        countryController.text = salonUser.data?.country ?? '';
        phoneNumberController.text = salonUser.data?.phoneNumber ?? '';
        genderController.text = salonUser.data?.gender ?? '';
        addressController.text = salonUser.data?.address ?? '';

        // Extract phone country code if available
        phoneCountryCode = findCountryCode(salonUser.data?.phoneNumber);
        phoneNumber = findPhoneNumber(salonUser.data?.phoneNumber);

        emit(UserDataFoundState(salonUser));
      }
    });

    on<SubmitEditProfileEvent>((event, emit) async {
      if (fullNameController.text.isEmpty) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.enterYourFullname, false);
        return;
      }

      AppRes.showCustomLoader();

      await ApiService().editUserDetails(
        fullname: fullNameController.text,
        nickname: nickNameController.text,
        dob: dobController.text,
        email: emailController.text,
        country: countryController.text,
        phoneNumber: '$phoneCountryCode $phoneNumberController.text',
        gender: genderController.text,
        address: addressController.text,
      );

      AppRes.hideCustomLoaderWithBack();
    });

    add(FetchUserProfileEvent());
  }

  // Controllers for form fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String phoneCountryCode = '91';
  String phoneNumber = '';

  // Utility functions for extracting phone data
  String findPhoneNumber(String? phone) {
    List<String>? text = phone?.split(' ');
    return (text != null && text.length >= 2) ? text.last : phone ?? '';
  }

  String findCountryCode(String? phone) {
    List<String>? text = phone?.split(' ');
    return (text != null && text.length >= 2) ? text.first : phone ?? '';
  }
}
