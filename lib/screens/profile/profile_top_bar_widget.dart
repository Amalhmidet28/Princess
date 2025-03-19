import 'package:cutfx/bloc/confirmbooking/payment_gateway.dart';
import 'package:cutfx/bloc/profile/profile_bloc.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/edit_profile_screen.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/screens/notification/notification_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ProfileTopBarWidget extends StatelessWidget {
  const ProfileTopBarWidget({
    super.key,
    required this.onMenuClick,
    this.salonUser,
    required Null Function() onTap,
  });

  final SalonUser? salonUser;
  final Function()? onMenuClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.themeColor5,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Première ligne : Menu, Titre "Profile", Icône de notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icône menu
                BgRoundImageWidget(
                  image: AssetRes.icMenu,
                  imagePadding: 8,
                  onTap: onMenuClick,
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 2), // Ajuste la position de l’image
                      child: Image.asset('asset/artwork.png', height: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35), // Décale le texte légèrement
                      child: Text(
                        AppLocalizations.of(context)!.profile,
                        style: kLightWhiteTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Figtree',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                // Icône de notification
                GestureDetector(
                  onTap: () {
                    Get.to(() => const NotificationScreen());
                  },
                  child: Image.asset(
                    AssetRes
                        .icNotification, // Assurez-vous que ce chemin est correct
                    height: 26, // Taille ajustable
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Section Profil
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image de profil
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: '',
                        image:
                            '${ConstRes.itemBaseUrl}${salonUser?.data?.profileImage ?? ''}',
                        fit: BoxFit.cover,
                        imageErrorBuilder: errorBuilderForImage,
                        placeholderErrorBuilder: loadingImage,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Nom de l'utilisateur
                  Text(
                    salonUser?.data?.fullname?.capitalize ?? '',
                    style: kBoldThemeTextStyle.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),

                  // Email de l'utilisateur
                  Text(
                    salonUser?.data?.email?.isNotEmpty == true
                        ? salonUser!.data!.email!
                        : 'email@example.com',
                    style: kThinWhiteTextStyle.copyWith(
                      color: ColorRes.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Figtree',
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // Bouton "Edit Details"
                  CustomCircularInkWell(
                    onTap: () {
                      Get.to(() => const EditProfileScreen())?.then((value) {
                        if (context.mounted) {
                          context.read<ProfileBloc>().add(FetchUserDataEvent());
                        }
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorRes.themeColor5,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Center(
                       
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
