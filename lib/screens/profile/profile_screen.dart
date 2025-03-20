import 'package:cutfx/bloc/profile/profile_bloc.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/NotifMenu/Notifbar.dart';
import 'package:cutfx/screens/address/manage_my_addresses.dart';
import 'package:cutfx/screens/booking/profile_booking_screen.dart';
import 'package:cutfx/screens/changelanguage/change_language.dart';
import 'package:cutfx/screens/edit_profile_screen.dart';
import 'package:cutfx/screens/notification/notification_screen.dart';
import 'package:cutfx/screens/profile/chnage_password_bottom.dart';
import 'package:cutfx/screens/profile/delete_account_bottom.dart';
import 'package:cutfx/screens/profile/profile_top_bar_widget.dart';
import 'package:cutfx/screens/security/securit%C3%A9.dart';
import 'package:cutfx/screens/wallet/wallet_screen.dart';
import 'package:cutfx/screens/web/web_view_screen.dart';
import 'package:cutfx/screens/welcome/welcome_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final Function()? onMenuClick;

  const ProfileScreen({super.key, this.onMenuClick});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          SalonUser? salonUser =
              state is UserDataFoundState ? state.salonUser : null;
          return salonUser != null
              ? Column(
                  children: [
                    ProfileTopBarWidget(
                      onMenuClick: onMenuClick,
                      salonUser: salonUser,
                      onTap: () {},
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.editProfile,
                              icon: Icons.supervised_user_circle_outlined,
                              onTap: () =>
                                  Get.to(() => const EditProfileScreen()),
                            ),
                            ProfileMenuItemWidget(
                              title:
                                  AppLocalizations.of(context)!.notifications,
                              icon: Icons.notification_add_outlined,
                              onTap: () => Get.to(
                                  () => const NotificationSettingsScreen()),
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.bookings,
                              icon: Icons.calendar_today,
                              onTap: () =>
                                  Get.to(() => const ProfileBookingScreen()),
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.security,
                              icon: Icons.lock,
                              onTap: () => Get.to(() => const SecurityScreen()),
                            ),
                            
                            ProfileMenuItemWidget(
                              title:
                                  AppLocalizations.of(context)!.changeLanguage,
                              icon: Icons.language,
                              onTap: () =>
                                  Get.to(() => const ChangeLanguageScreen()),
                            ),
                            ProfileMenuItemWidget(
                              title:
                                  AppLocalizations.of(context)!.privacyPolicy,
                              icon: Icons.privacy_tip,
                              onTap: () => Get.to(() => const WebViewScreen(),
                                  arguments: AppLocalizations.of(context)!
                                      .privacyPolicy),
                            ),
                            Visibility(
                              visible: ConstRes.userIdValue != -1,
                              child: ProfileMenuItemWidget(
                                title: AppLocalizations.of(context)!.logOut,
                                icon: Icons.logout,
                                onTap: () {
                                  Get.bottomSheet(
                                    _buildLogoutBottomSheet(context),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const LoadingData();
        },
      ),
    );
  }

  /// Logout Confirmation Bottom Sheet
  Widget _buildLogoutBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 245, 245),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            AppLocalizations.of(context)!.logOut,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.logoutDec,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 225, 201),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                  child: const Text("No",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    AppRes.showCustomLoader();
                    await ApiService().editUserDetails(
                        deviceToken: 'none',
                        nickname: '',
                        dob: '',
                        email: '',
                        address: '',
                        gender: '',
                        country: '');
                    FirebaseAuth.instance.signOut();
                    AppRes.hideCustomLoader();
                    SharePref sharedPref = await SharePref().init();
                    sharedPref.clear();
                    Get.offAll(const WelcomeScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5E3B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                  child: const Text("Yes, Logout",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
} 

class ProfileMenuItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const ProfileMenuItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: ColorRes.black, size: 22), // Icon added
            const SizedBox(width: 15), // Space between icon and text
            Expanded(
              child: Text(
                title,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.black,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.grey, size: 16), // Arrow indicator
          ],
        ),
      ),
    );
  }
}

class ToggleButton extends StatefulWidget {
  final Function(bool isEnable)? onValueChange;
  final bool? value;

  const ToggleButton({
    super.key,
    this.onValueChange,
    this.value,
  });

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool buttonIsActive = false;

  @override
  void initState() {
    buttonIsActive = widget.value ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: buttonIsActive,
      activeColor: ColorRes.themeColor,
      onChanged: (value) {
        buttonIsActive = value;
        widget.onValueChange?.call(value);
        setState(() {});
      },
    );
  }
}
