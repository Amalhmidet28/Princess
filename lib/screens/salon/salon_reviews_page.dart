import 'package:cutfx/bloc/review/review_bloc.dart';
import 'package:cutfx/model/review/salon_review.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SalonReviewsPage extends StatefulWidget {
  final SalonData? salonData;

  const SalonReviewsPage({super.key, required this.salonData});

  @override
  State<SalonReviewsPage> createState() => _SalonReviewsPageState();
}

class _SalonReviewsPageState extends State<SalonReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewBloc(),
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          ReviewBloc reviewBloc = context.read<ReviewBloc>();
          return SingleChildScrollView(
            controller: reviewBloc.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: ColorRes.smokeWhite,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star_rounded, color: ColorRes.themeColor, size: 24),
                          const SizedBox(width: 5),
                          Text(
                            '${widget.salonData?.rating?.toStringAsFixed(1) ?? '0.0'} ',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '(${widget.salonData?.reviewsCount ?? 0} reviews)',
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.empress,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                state is ReviewDataFetchedState
                    ? ListView.builder(
                        itemCount: reviewBloc.reviews.length,
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        itemBuilder: (context, index) {
                          ReviewData? review = reviewBloc.reviews[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: FadeInImage.assetNetwork(
                                          height: 50,
                                          width: 50,
                                          placeholder: '1',
                                          image: '${ConstRes.itemBaseUrl}${review.user?.profileImage ?? ''}',
                                          fit: BoxFit.cover,
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return const ImageNotFoundOval(fontSize: 40);
                                          },
                                          placeholderErrorBuilder: loadingImageTransParent,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                review.user?.fullname ?? '',
                                                style: kRegularTextStyle,
                                              ),
                                              const Spacer(),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: ColorRes.darkGray),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.star_rounded, color: ColorRes.themeColor, size: 16),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      review.rating?.toString() ?? '0',
                                                      style: kRegularTextStyle.copyWith(fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Icon(Icons.more_vert, color: ColorRes.darkGray)
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            review.comment ?? '',
                                            style: kLightWhiteTextStyle.copyWith(
                                              color: ColorRes.empress,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Divider(color: ColorRes.darkGray.withOpacity(0.3)),
                              ],
                            ),
                          );
                        },
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(
                          child: LoadingData(color: ColorRes.white),
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
