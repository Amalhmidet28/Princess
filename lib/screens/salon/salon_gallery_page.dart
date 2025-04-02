import 'package:cutfx/screens/notification/notification_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:cutfx/bloc/salon/salon_details_bloc.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/gallery/gallery_screen.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SalonGalleryPage extends StatelessWidget {
  const SalonGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SalonDetailsBloc salonDetailsBloc = context.read<SalonDetailsBloc>();
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Our Gallery',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Pass the `SalonData` object to the GalleryScreen
                    Get.to(() => const GalleryScreen(), arguments: {
                      ConstRes.salonData: salonDetailsBloc.salonData,
                    });
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorRes.themeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Gallery Section
          StaggeredGrid.count(
            crossAxisCount: 3,
            axisDirection: AxisDirection.down,
            children: List.generate(
              salonDetailsBloc.salonData?.gallery?.length ?? 0,
              (index) {
                Gallery? gallery = salonDetailsBloc.salonData?.gallery?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: InkWell(
                    onTap: () => Get.to(() => const GalleryScreen(), arguments: {
                      ConstRes.salonData: salonDetailsBloc.salonData,
                      ConstRes.gallery: gallery
                    }),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        height: 200, // Fixed height for all images
                        width: double.infinity, // Makes image width fill container
                        child: FadeInImage.assetNetwork(
                          image: '${ConstRes.itemBaseUrl}${gallery?.image}',
                          fit: BoxFit.cover,
                          imageErrorBuilder: errorBuilderForImage,
                          placeholderErrorBuilder: loadingImage,
                          placeholder: '1',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the SalonData object from arguments
    final arguments = Get.arguments as Map<String, dynamic>;
    final SalonData? salonData = arguments[ConstRes.salonData]; // SalonData object

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Our Gallery',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Image.asset(AssetRes.icNotification),  // Custom icon
            onPressed: () {
              // Navigate to the notification screen
              Get.to(() => const NotificationScreen());
            },
          ),
        ],
      ),
      body: salonData?.gallery != null && salonData!.gallery!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8.0, // Space between images horizontally
                  mainAxisSpacing: 8.0, // Space between images vertically
                  childAspectRatio: 1.0, // Ensure the images have the same aspect ratio (square)
                ),
                itemCount: salonData.gallery!.length,
                itemBuilder: (context, index) {
                  Gallery? gallery = salonData.gallery![index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      image: '${ConstRes.itemBaseUrl}${gallery?.image}',
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                      placeholder: 'assets/loading_image.png',
                    ),
                  );
                },
              ),
            )
          : const Center(child: Text('No images available')),
    );
  }
}
