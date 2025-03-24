import 'package:cutfx/bloc/fav/favourite_bloc.dart';
import 'package:cutfx/bloc/fav/favourite_state.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/salon/salon_details_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SalonScreen extends StatelessWidget {
  const SalonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return state is FavouriteDataFound
            ? (state.favouriteData.data != null &&
                    state.favouriteData.data!.salons!.isNotEmpty
                ? ListView.builder(
                    itemCount: state.favouriteData.data?.salons?.length ?? 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    itemBuilder: (context, index) {
                      SalonData? salonData =
                          state.favouriteData.data?.salons?[index];
                      return ItemSalon(
                        salonData: salonData,
                      );
                    },
                  )
                : const Center(child: DataNotFound()))
            : const LoadingData(
                color: ColorRes.white,
              );
      },
    );
  }
}

class ItemSalon extends StatelessWidget {
  final SalonData? salonData;

  const ItemSalon({
    super.key,
    this.salonData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(
          () => const SalonDetailsScreen(),
          arguments: salonData?.id?.toInt(),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: ColorRes.white,
          boxShadow: const [
            BoxShadow(
              color: ColorRes.smokeWhite1,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: SizedBox(
                width: 80, // Reduced image width
                height: 80, // Reduced image height
                child: FadeInImage.assetNetwork(
                  image: '${ConstRes.itemBaseUrl}${salonData!.images!.isNotEmpty ? (salonData?.images?[0].image ?? '') : ''}',
                  fit: BoxFit.cover,
                  imageErrorBuilder: errorBuilderForImage,
                  placeholderErrorBuilder: loadingImage,
                  placeholder: '1',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      salonData?.salonName ?? '',
                      style: kSemiBoldTextStyle.copyWith(
                        color: ColorRes.nero,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      salonData?.salonAddress ?? '',
                      style: kThinWhiteTextStyle.copyWith(
                        color: ColorRes.empress,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: ColorRes.pumpkin,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          salonData?.rating?.toStringAsFixed(1) ?? '0.0',
                          style: kRegularTextStyle.copyWith(
                            color: ColorRes.pumpkin,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${AppRes.calculateDistance(double.parse(salonData?.salonLat ?? '0'), double.parse(salonData?.salonLong ?? '0'))} km away',
                          style: kThinWhiteTextStyle.copyWith(
                            color: ColorRes.mortar,
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
