import 'package:cutfx/bloc/confirmbooking/payment_gateway.dart';
import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/screens/fav/favourite_screen.dart';
import 'package:cutfx/screens/home/top_rated_salon.dart';
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
import 'package:cutfx/screens/categories/categories_screen.dart';
import 'package:cutfx/screens/toprated/top_rated_salon_screen.dart';

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
          HomePageData? homePageData = state is HomeDataFoundState ? state.homePageData : null;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  Image.asset(
                    'asset/artwork.png',
                    height: 30,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Morning, ${salonUser?.data?.fullname ?? ""} 👋',
                    style: const TextStyle(
                      fontFamily: 'RecklessNeue-Bold',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                  const Spacer(),
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
                    _buildCategoriesSection(homePageData),
                    const SizedBox(height: 20),
                  
                    const SizedBox(height: 20),
                    _buildTopRatedSalonsSection(homePageData),
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
          const Icon(Icons.search, color: Color.fromARGB(255, 230, 186, 145)),
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
                color: Color.fromARGB(255, 230, 186, 145)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(HomePageData? homePageData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
          ),
          itemCount: homePageData?.data?.categories?.length ?? 0,
          itemBuilder: (context, index) {
            var category = homePageData?.data?.categories?[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => const CategoriesScreen());
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color.fromARGB(255, 248, 232, 215),
                    child: Icon(Icons.category, color: const Color(0xFFA67C52)),
                  ),
                  const SizedBox(height: 5),
                  Text(category?.title ?? 'Category'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTopRatedSalonsSection(HomePageData? homePageData) {
  // Récupération des salons les mieux notés depuis les données
  final topRatedSalons = homePageData?.data?.topRatedSalons ?? [];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          "Most popular",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 10),
      // Utilisation de TopRatedSalonsWidget pour afficher les salons
      TopRatedSalonsWidget(topRatedSalons: topRatedSalons),
    ],
  );
}

  Widget _buildMostPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Near your Location",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Text("Salon Name", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("1.2 km  |  ★ 4.8", style: TextStyle(color: Colors.grey)),
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
                    placeholder: '0',
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

