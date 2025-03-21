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
import 'package:image_picker/image_picker.dart';

class ProfileTopBarWidget extends StatefulWidget {
  const ProfileTopBarWidget({
    super.key,
    required this.onMenuClick,
    this.salonUser,
    required Null Function() onTap,
  });

  final SalonUser? salonUser;
  final Function()? onMenuClick;

  @override
  _ProfileTopBarWidgetState createState() => _ProfileTopBarWidgetState();
}

class _ProfileTopBarWidgetState extends State<ProfileTopBarWidget> {
  late SalonUser? salonUser;

  @override
  void initState() {
    super.initState();
    salonUser = widget.salonUser;  // Initialize salonUser to reflect the initial data.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.themeColor5,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2), 
                      child: Image.asset('asset/artwork.png', height: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35), 
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
                GestureDetector(
                  onTap: () {
                    Get.to(() => const NotificationScreen());
                  },
                  child: Image.asset(AssetRes.icNotification),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: (salonUser?.profileImage ?? '').isNotEmpty
                            ? NetworkImage(salonUser!.profileImage!)
                            : const AssetImage("assets/default_profile.png") as ImageProvider,
                      ),
                      // Edit Icon
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: InkWell(
                          onTap: () {
                            _showImagePicker(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5E3B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    salonUser?.data?.fullname?.capitalize ?? '',
                    style: kBoldThemeTextStyle.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
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
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Center(
                        child: Text('Edit Details'),
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

  // Function to show the image picker modal
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.camera, context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.gallery, context);
              },
            ),
          ],
        );
      },
    );
  }

  // Picks an image from Camera or Gallery
  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // Upload image and update UI
      await _uploadProfilePicture(pickedFile.path);
    }
  }

  // Uploads the image to the server
  Future<void> _uploadProfilePicture(String filePath) async {
    // Implement image upload API call here

    // After the image is uploaded, update the salonUser object
    setState(() {
      salonUser!.profileImage = filePath; // Update the profile image URL
    });

    print("Uploading image: $filePath");
  }
}
