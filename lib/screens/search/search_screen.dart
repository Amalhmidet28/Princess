import 'package:cutfx/bloc/search/search_bloc.dart';
import 'package:cutfx/bloc/search/search_event.dart';
import 'package:cutfx/bloc/search/search_state.dart';
import 'package:cutfx/screens/search/search_salon_screen.dart';
import 'package:cutfx/screens/search/search_service_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class SearchScreen extends StatelessWidget {
  final PageController pageController = PageController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SearchBloc(),
        child: Column(
          children: [
            Container(
              color: ColorRes.smokeWhite,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 15),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          
                          const Spacer(),
                         
                           
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                // physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SearchServiceScreen(),
                  SearchSalonScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
