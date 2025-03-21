import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/screens/categories/salon_by_cat_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    List<Categories> categories =
        (arguments is List<Categories>) ? arguments : [];

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.categories,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.2,
              ),
              itemCount: categories.length,
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              itemBuilder: (context, index) {
                Categories category = categories[index];
                return CustomCircularInkWell(
                  onTap: () {
                    Get.to(
                      () => const CategoryDetailScreen(),
                      arguments: category,
                    );
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ClipOval(
                        // Rend le container circulaire
                        child: Container(
                          width: 80, // Taille du cercle
                          height: 80,
                          decoration: const BoxDecoration(
                            color: ColorRes.lavender,
                            shape: BoxShape.circle, // Rend le fond circulaire
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: ClipOval(
                                // Rend l'image circulaire
                                child: FadeInImage.assetNetwork(
                                  image:
                                      '${ConstRes.itemBaseUrl}${category.icon}',
                                  imageErrorBuilder: errorBuilderForImage,
                                  placeholder: '1',
                                  placeholderErrorBuilder:
                                      loadingImageTransParent,
                                  fit: BoxFit.cover, // Ajuste l'image au cercle
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        category.title ?? '',
                        textAlign: TextAlign.center,
                        style: kRegularThemeTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
