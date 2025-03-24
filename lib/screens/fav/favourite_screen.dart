import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cutfx/bloc/fav/favourite_bloc.dart';
import 'package:cutfx/bloc/fav/favourite_event.dart';
import 'package:cutfx/bloc/fav/favourite_state.dart';
import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/screens/fav/salon_screen.dart';
import 'package:cutfx/screens/fav/service_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreen extends StatefulWidget {
  final HomePageData? homePageData;
  final Function()? onMenuClick;

  const FavouriteScreen({super.key, this.onMenuClick, this.homePageData});

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final PageController pageController = PageController(keepPage: true);
  List<String> categories = ['All']; // Start with "All"
  String selectedCategory = 'All';

  HomePageData? get homePageData => null; // Default selected category

// @override
// void initState() {
//   super.initState();
//   Future.delayed(Duration.zero, () {
//     _fetchCategories(widget.homePageData);
//   });
// }
// void _fetchCategories(HomePageData? homePageData) {
//   setState(() {
//     categories = [
//       'All',
//       ...(homePageData?.data?.categories ?? []).map((e) => e.title ?? 'Unknown')
//     ];
//   });
// }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header with category filters
            Container(
              color: ColorRes.themeColor5,
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Toggle (Service/Salon)
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Text(
                          AppLocalizations.of(context)!.favourite,
                          style: const TextStyle(
                            fontFamily: 'Figtree',
                            fontSize: 24,
                            color: ColorRes.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<FavouriteBloc, FavouriteState>(
                          builder: (context, state) {
                            int selectedIndex =
                                context.read<FavouriteBloc>().selectedIndex;
                            return Row(
                              children: [
                                CustomCircularInkWell(
                                  onTap: () {
                                    context
                                        .read<FavouriteBloc>()
                                        .add(OnTabClickEvent(0));
                                    pageController.jumpToPage(0);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedIndex == 0
                                          ? ColorRes.themeColor
                                          : ColorRes.smokeWhite1,
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                        left: Radius.circular(100),
                                      ),
                                    ),
                                    width: 90,
                                    height: 40,
                                    child: Center(
                                      // child: Text(
                                      //   AppLocalizations.of(context)!.service,
                                      //   style: kLightWhiteTextStyle.copyWith(
                                      //     color: selectedIndex == 0
                                      //         ? ColorRes.white
                                      //         : ColorRes.empress,
                                      //     fontSize: 16,
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                                CustomCircularInkWell(
                                  onTap: () {
                                    context
                                        .read<FavouriteBloc>()
                                        .add(OnTabClickEvent(1));
                                    pageController.jumpToPage(1);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedIndex == 1
                                          ? ColorRes.themeColor
                                          : ColorRes.smokeWhite1,
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                        right: Radius.circular(100),
                                      ),
                                    ),
                                    width: 90,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.salon,
                                        style: kLightWhiteTextStyle.copyWith(
                                          color: selectedIndex == 1
                                              ? ColorRes.white
                                              : ColorRes.empress,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _categoryChips(homePageData), // Updated category list
                  ],
                ),
              ),
            ),

            // PageView with Service and Salon screens
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: const [
                  //ServiceScreen(),
                  SalonScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
