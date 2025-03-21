import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/screens/categories/salon_by_cat_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesGridWidget extends StatelessWidget {
  final List<Categories> categories;

  const CategoriesGridWidget({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, 
          childAspectRatio: 1.2 / 1,
        ),
        itemCount: categories.length >= 4 ? 4 : categories.length,
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
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
                const SizedBox(height: 5),
                ClipOval(  // Assure que tout le contenu est circulaire
                  child: Container(
                    width: 80,  // Taille du cercle
                    height: 80,
                    decoration: const BoxDecoration(
                    
                      shape: BoxShape.circle,  // Applique la forme circulaire
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipOval(  // Assure que l'image reste circulaire
                        child: FadeInImage.assetNetwork(
                          image: '${ConstRes.itemBaseUrl}${category.icon}',
                          imageErrorBuilder: errorBuilderForImage,
                          placeholderErrorBuilder: loadingImageTransParent,
                          placeholder: '1',
                          fit: BoxFit.cover,  // Ajuste l'image au cercle
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
    );
  }
}
