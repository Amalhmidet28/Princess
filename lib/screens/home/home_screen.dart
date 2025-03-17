import 'package:cutfx/bloc/home/home_bloc.dart';
import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/categories/categories_screen.dart';
import 'package:cutfx/screens/fav/favourite_screen.dart';
import 'package:cutfx/screens/home/categories.dart';
import 'package:cutfx/screens/home/categories_with_salons.dart';
import 'package:cutfx/screens/home/near_by_salon.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/screens/nearbysalon/near_by_salon_screen.dart';
import 'package:cutfx/screens/notification/notification_screen.dart';
import 'package:cutfx/screens/toprated/top_rated_salon_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'top_rated_salon.dart';

class HomeScreen extends StatelessWidget {
  final Function()? onMenuClick;

  const HomeScreen({
    super.key,
    this.onMenuClick,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.9);
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          HomePageData? homePageData =
              state is HomeDataFoundState ? state.homePageData : null;
          HomeBloc homeBloc = context.read<HomeBloc>();
          SalonUser? salonUser = homeBloc.salonUser;
          return Column(
            children: [
              Container(
                color: ColorRes.themeColor5,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          Image.asset(
                            'asset/artwork.png',
                            height: 30,
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
                          BgRoundImageWidget(
                            image: AssetRes.icNotification,
                            imagePadding: 10,
                            onTap: () {
                              Get.to(() => const NotificationScreen());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 15), // Espace pour descendre le texte
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15), // Décalage vers la droite
                        child: Text(
                          'Morning, ${salonUser?.data?.fullname ?? ""} 👋',
                          style: const TextStyle(
                            fontFamily: 'RecklessNeue-Bold',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Color(0xFFB1A89D)),

                    suffixIcon: Icon(Icons.tune, color: Color(0xFFA57864)),
                    // Icône de filtre
                    filled: true,
                    fillColor: const Color(0xFFF5ECE0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    // Logique de filtrage si nécessaire
                  },
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: state is HomeInitial
                    ? const LoadingData()
                    : SingleChildScrollView(
                        child: SafeArea(
                          top: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              BannerWidget(
                                pageController: pageController,
                                homePageData: homePageData,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TitleWithSeeAllWidget(
                                title: AppLocalizations.of(context)!.categories,
                                onTap: () => Get.to(
                                  () => const CategoriesScreen(),
                                  arguments:
                                      homePageData?.data?.categories ?? [],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: CategoriesGridWidget(
                                  categories:
                                      homePageData?.data?.categories ?? [],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TitleWithSeeAllWidget(
                                title: AppLocalizations.of(context)!
                                    .topRatedSalons,
                                onTap: () {
                                  Get.to(
                                      () => const TopRatedSalonScreen(
                                            salon: null,
                                          ),
                                      arguments:
                                          homePageData?.data?.topRatedSalons ??
                                              []);
                                },
                              ),
                              TopRatedSalonsWidget(
                                topRatedSalons:
                                    homePageData?.data?.topRatedSalons ?? [],
                              ),
                              Visibility(
                                visible: homeBloc.salons.isNotEmpty,
                                child: TitleWithSeeAllWidget(
                                  title: AppLocalizations.of(context)!
                                      .nearBySalons,
                                  onTap: () =>
                                      Get.to(() => const NearBySalonScreen()),
                                ),
                              ),
                              Visibility(
                                visible: homeBloc.salons.isNotEmpty,
                                child: NearBySalonsWidget(
                                  nearBySalons: homeBloc.salons,
                                ),
                              ),
                              CategoriesWithSalonsWidget(
                                categoriesWithServices:
                                    homePageData?.data?.categoriesWithService ??
                                        [],
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
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
