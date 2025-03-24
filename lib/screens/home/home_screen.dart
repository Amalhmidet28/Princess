import 'package:cutfx/bloc/home/home_bloc.dart';
import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/categories/categories_screen.dart';
import 'package:cutfx/screens/fav/favourite_screen.dart';
import 'package:cutfx/screens/home/categories.dart';
import 'package:cutfx/screens/home/near_by_salon.dart';
import 'package:cutfx/screens/home/top_rated_salon.dart';
import 'package:cutfx/screens/nearbysalon/near_by_salon_screen.dart';
import 'package:cutfx/screens/notification/notification_screen.dart';
import 'package:cutfx/screens/search/search_screen.dart';
import 'package:cutfx/screens/toprated/top_rated_salon_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final Function()? onMenuClick;

  const HomeScreen({super.key, this.onMenuClick});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

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
          List<SalonData> salons =
              (homePageData?.data?.topRatedSalons ?? []).cast<SalonData>();

// Filter salons based on the selected category
          List<SalonData> filteredSalons = selectedCategory == 'All'
    ? salons
    : salons.where((salon) {
        if (salon.categories == null) return false; // Handle null case
        if (salon.categories is String) {
          return salon.categories == selectedCategory;
        } else if (salon.categories is List<String>) {
          return salon.categories?.contains(selectedCategory) ?? false;
        }
        return false;
      }).toList();


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
                          Image.asset('asset/artwork.png', height: 30),
                          const Spacer(),
                          _iconButton(AssetRes.icfav,
                              () => Get.to(() => FavouriteScreen(homePageData: null,))),
                          const SizedBox(width: 15),
                          _iconButton(AssetRes.icNotification,
                              () => Get.to(() => const NotificationScreen())),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
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

              _searchBar(context),
              Expanded(
                child: state is HomeInitial
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BannerWidget(
                                pageController: pageController,
                                homePageData: homePageData),

                            CategoriesGridWidget(
                                categories:
                                    homePageData?.data?.categories ?? []),

                            _sectionTitle(context, 'Most popular', () => Get.to(() => const TopRatedSalonScreen(salon: null), arguments: homePageData?.data?.topRatedSalons ?? [])),
                            _categoryChips(
                                homePageData), const SizedBox(width: 50), // Category filter chips
                            TopRatedSalonsWidget(
                                topRatedSalons:
                                    filteredSalons), 
                            if (homeBloc.salons.isNotEmpty) ...[
                              _sectionTitle(
                                context,
                                'Nearby Salons',
                                () => Get.to(
                                    () => const NearBySalonScreen(salon: null)),
                              ),
                              NearBySalonsWidget(nearBySalons: homeBloc.salons),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget for filtering categories
 Widget _categoryChips(HomePageData? homePageData) {
  List<String> categories = [
    'All',
    ...?homePageData?.data?.categories?.map((e) => e.title ?? '')
  ];

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      children: categories
          .map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(category,
                    style: TextStyle(
                      color: selectedCategory == category
                          ? Colors.white
                          : const Color(0xFFA57864), 
                      fontWeight: FontWeight.bold,
                    )),
                selected: selectedCategory == category,
                selectedColor: const Color(0xFFA57864), 
                backgroundColor: Colors.transparent,
                shape: category == 'All'
                    ? null
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(
                            color: Color(0xFFA57864), width: 2), 
                      ),
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
            ),
          )
          .toList(),
    ),
  );
}

  // Icon Button Widget
  Widget _iconButton(String image, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(image, height: 30),
        ),
      ),
    );
  }

  // Search Bar Widget
  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search, color: Color(0xFFB1A89D)),
          suffixIcon: const Icon(Icons.tune, color: Color(0xFFA57864)),
          filled: true,
          fillColor: const Color(0xFFF5ECE0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: () => Get.to(() => SearchScreen()),
      ),
    );
  }

  // Section Title Widget
  Widget _sectionTitle(BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          GestureDetector(
              onTap: onTap,
              child: const Text('See All',
                  style: TextStyle(color: ColorRes.primary))),
        ],
      ),
    );
  }
}

// Banner Widget
class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {super.key, required this.pageController, this.homePageData});

  final PageController pageController;
  final HomePageData? homePageData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.93 / 1,
      child: PageView.builder(
        controller: pageController,
        itemCount: homePageData?.data?.banners?.length ?? 0,
        itemBuilder: (context, index) {
          final banner = homePageData?.data?.banners?[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              image: '${ConstRes.itemBaseUrl}${banner?.image ?? ''}',
              fit: BoxFit.cover,
              placeholder: 'asset/loading.png',
              placeholderErrorBuilder: (_, __, ___) =>
                  const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
