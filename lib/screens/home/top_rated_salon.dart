import 'dart:ui';

import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TopRatedSalonsWidget extends StatelessWidget {
  const TopRatedSalonsWidget({
    super.key,
    required this.topRatedSalons,
  });
  final List<SalonData> topRatedSalons;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical, 
            shrinkWrap: true, // Ensures list takes only needed space
            physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
            itemCount: topRatedSalons.length,
            itemBuilder: (context, index) {
              SalonData salonData = topRatedSalons[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ItemTopRatedSalon(salonData),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemTopRatedSalon extends StatelessWidget {
  final SalonData salonData;

  const ItemTopRatedSalon(
    this.salonData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 252, 246, 246).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: FadeInImage.assetNetwork(
                image:
                    '${ConstRes.itemBaseUrl}${(salonData.images != null && salonData.images!.isNotEmpty) ? salonData.images![0].image : ''}',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                imageErrorBuilder: errorBuilderForImage,
                placeholderErrorBuilder: loadingImage,
                placeholder: '1',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      salonData.salonName ?? '',
                      style: kSemiBoldWhiteTextStyle.copyWith(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      salonData.salonAddress ?? '',
                      style: kThinWhiteTextStyle.copyWith(
                          color: const Color.fromARGB(255, 103, 100, 100)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: ColorRes.themeColor),
                            const SizedBox(width: 4),
                            Text(
                              salonData.rating?.toStringAsFixed(1) ?? '0.0',
                              style: kLightWhiteTextStyle.copyWith(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${AppRes.calculateDistance(double.parse(salonData.salonLat ?? '0'), double.parse(salonData.salonLong ?? '0'))} km away',
                          style: kLightWhiteTextStyle.copyWith(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 103, 100, 100),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
