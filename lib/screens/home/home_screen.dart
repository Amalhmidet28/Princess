import 'package:cutfx/bloc/confirmbooking/payment_gateway.dart';
import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/screens/fav/favourite_screen.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/screens/notification/notification_screen.dart';
import 'package:cutfx/screens/search/search_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cutfx/bloc/home/home_bloc.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/style_res.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          HomeBloc homeBloc = context.read<HomeBloc>();
          SalonUser? salonUser = homeBloc.salonUser;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  Image.asset(
                    'asset/artwork.png',
                    height: 30, // Adjust according to your logo size
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Morning, ${salonUser?.data?.fullname ?? ""} 👋',
                    style: const TextStyle(
                      fontFamily: 'RecklessNeue-Bold',
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Material(
                    color: Colors.transparent,
                    child: BgRoundImageWidget(
                      image: AssetRes.icfav,
                      imagePadding: 9,
                      onTap: () {
                        Get.to(() => FavouriteScreen());
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Material(
                    color: Colors.transparent,
                    child: BgRoundImageWidget(
                      image: AssetRes.icNotification,
                      imagePadding: 9,
                      onTap: () {
                        Get.to(() => const NotificationScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildSearchBar(),
                    const SizedBox(height: 20),
                    _buildCategoriesSection(),
                    const SizedBox(height: 20),
                    // You can place your BannerWidget here directly
                    BannerWidget(
                      pageController: PageController(),
                      homePageData: HomePageData(),
                    ),
                    const SizedBox(height: 20),
                    _buildMostPopularSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5ECE0),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color.fromARGB(255, 245, 219, 194)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune,
                color: Color.fromARGB(255, 245, 219, 194)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryIcon("Haircuts", Icons.cut),
            _buildCategoryIcon("Make up", Icons.brush),
            _buildCategoryIcon("Pedicure", Icons.spa),
            _buildCategoryIcon("Massage", Icons.self_improvement),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryIcon(String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color.fromARGB(255, 248, 232, 215),
          child: Icon(icon, color: const Color(0xFFA67C52), size: 30),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildMostPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Most Popular",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("See All"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildPopularSalonCard(),
      ],
    );
  }

  Widget _buildPopularSalonCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Salon Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "1.2 km  |  ★ 4.8",
                    style: TextStyle(color: Colors.grey),
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

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.pageController,
    this.homePageData,
  });

  final PageController pageController;
  final HomePageData? homePageData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.93 / 1,
      child: PageView.builder(
        pageSnapping: true,
        padEnds: true,
        controller: pageController,
        itemCount: homePageData?.data?.banners?.length ?? 0,
        itemBuilder: (context, index) {
          Banners? banners = homePageData?.data?.banners?[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 7.5),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Stack(
                children: [
                  FadeInImage.assetNetwork(
                    image: '${ConstRes.itemBaseUrl}${banners?.image ?? ''}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: '1',
                    placeholderErrorBuilder: loadingImage,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        height: 30,
                        width: 15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(100),
                          ),
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Container(
                        height: 30,
                        width: 15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(100),
                          ),
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
