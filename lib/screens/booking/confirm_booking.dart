import 'dart:io';

import 'package:cutfx/bloc/bookings/bookings_bloc.dart';
import 'package:cutfx/model/slot/slot.dart';
import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmBookingScreen extends StatelessWidget {
  const ConfirmBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingsBloc(),
      child: Scaffold(
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.confirmBooking,
            ),
            Expanded(
              child: BlocBuilder<BookingsBloc, BookingsState>(
                builder: (context, state) {
                  BookingsBloc bookingsBloc = context.read<BookingsBloc>();

                  var selectedStaff;
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),

                                //calendar
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFFF4E5DA), // Light beige background
                                    borderRadius: BorderRadius.circular(
                                        15), // Rounded corners
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: TableCalendar(
                                    firstDay: DateTime.utc(2020, 1, 1),
                                    lastDay: DateTime.utc(2030, 12, 31),
                                    focusedDay: bookingsBloc.selectedDate ??
                                        DateTime.now(),
                                    selectedDayPredicate: (day) {
                                      return isSameDay(
                                          day, bookingsBloc.selectedDate);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      bookingsBloc.onClickCalenderDay(
                                          selectedDay, bookingsBloc);
                                    },

                                    // Calendar Style
                                    calendarStyle: CalendarStyle(
                                      isTodayHighlighted: true,
                                      outsideDaysVisible: false,
                                      selectedDecoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFA67C52),
                                            Color(0xFFE3B788)
                                          ], // Gradient for selection
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      selectedTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      todayDecoration: BoxDecoration(
                                        color: Color(0xFFEAD7C0),
                                        shape: BoxShape.circle,
                                      ),
                                      todayTextStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      defaultTextStyle: TextStyle(
                                        color: Color(0xFF444444),
                                        fontSize: 16,
                                      ),
                                      weekendTextStyle: TextStyle(
                                        color: Color(0xFFA67C52),
                                        fontSize: 16,
                                      ),
                                    ),

                                    // Header Style
                                    headerStyle: HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                      titleTextStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF444444),
                                      ),
                                      leftChevronIcon: Icon(
                                        Icons.chevron_left,
                                        color: Color(0xFFA67C52),
                                      ),
                                      rightChevronIcon: Icon(
                                        Icons.chevron_right,
                                        color: Color(0xFFA67C52),
                                      ),
                                    ),

                                    // Weekday Row
                                    daysOfWeekStyle: DaysOfWeekStyle(
                                      weekdayStyle: TextStyle(
                                        color: Color(0xFF444444),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      weekendStyle: TextStyle(
                                        color: Color(0xFFA67C52),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                Text(
                                  AppLocalizations.of(context)!.selectBarber,
                                  style: kLightWhiteTextStyle.copyWith(
                                    fontSize: 16,
                                    color: ColorRes.empress,
                                  ),
                                ),
                                ItemStaff(
                                  staffData: bookingsBloc.staffData,
                                  onTapChange: () {
                                    bookingsBloc.selectStaff(bookingsBloc);
                                  },
                                ),
                                Text(
                                  AppLocalizations.of(context)!.selectTime,
                                  style: kLightWhiteTextStyle.copyWith(
                                    fontSize: 16,
                                    color: ColorRes.empress,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 60,
                                  child: state is BookingsInitial
                                      ? const Center(
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : bookingsBloc.slots.isEmpty
                                          ? Container(
                                              decoration: const BoxDecoration(
                                                color: ColorRes.smokeWhite,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .noSlotsAvailable,
                                                  style:
                                                      kRegularEmpressTextStyle
                                                          .copyWith(
                                                    color: ColorRes.darkGray,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount:
                                                  bookingsBloc.slots.length,
                                              padding: const EdgeInsets.all(0),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                SlotData? slotData =
                                                    bookingsBloc.slots[index];
                                                int hour = bookingsBloc
                                                        .selectedTime?.hour ??
                                                    0;
                                                int min = bookingsBloc
                                                        .selectedTime?.minute ??
                                                    0;
                                                String selectedTime =
                                                    '${hour < 10 ? '0$hour' : '$hour'}${min < 10 ? '0$min' : '$min'}';

                                                DateTime dateTime = DateTime(
                                                    DateTime.now().year,
                                                    bookingsBloc.month,
                                                    bookingsBloc.day,
                                                    int.parse(slotData.time
                                                            ?.substring(0, 2) ??
                                                        '0'),
                                                    int.parse(slotData.time
                                                            ?.substring(2, 4) ??
                                                        '0'));
                                                DateTime current =
                                                    DateTime.now();
                                                bool isAvailable = slotData
                                                            .available ==
                                                        true &&
                                                    dateTime
                                                            .difference(current)
                                                            .inMinutes >
                                                        5;
                                                bool isSelected =
                                                    selectedTime ==
                                                        slotData.time;
                                                return CustomCircularInkWell(
                                                  onTap: () {
                                                    if (!isAvailable) {
                                                      return;
                                                    }
                                                    bookingsBloc.selectedTime =
                                                        TimeOfDay(
                                                      hour: AppRes
                                                          .getHourFromTime(AppRes
                                                              .convert24HoursInto12Hours(
                                                                  slotData
                                                                      .time)),
                                                      minute: int.parse(
                                                        AppRes.getMinFromTime(AppRes
                                                            .convert24HoursInto12Hours(
                                                                slotData.time)),
                                                      ),
                                                    );
                                                    bookingsBloc.add(
                                                        FetchBookingsArgumentsEvent());
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 95,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isSelected
                                                              ? ColorRes
                                                                  .themeColor
                                                              : ColorRes
                                                                  .smokeWhite,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(5),
                                                          ),
                                                        ),
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          AppRes
                                                              .convert24HoursInto12Hours(
                                                                  slotData
                                                                      .time),
                                                          style:
                                                              kBoldWhiteTextStyle
                                                                  .copyWith(
                                                            color: isSelected
                                                                ? ColorRes.white
                                                                : !isAvailable
                                                                    ? ColorRes
                                                                        .darkGray
                                                                    : ColorRes
                                                                        .charcoal,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        !isAvailable
                                                            ? AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .notAvailable
                                                            : AppLocalizations
                                                                    .of(context)!
                                                                .available,
                                                        style: kRegularTextStyle
                                                            .copyWith(
                                                          color: !isAvailable
                                                              ? ColorRes
                                                                  .darkGray
                                                              : ColorRes
                                                                  .islamicGreen,
                                                          fontSize: 13,
                                                          letterSpacing: .4,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Text(
                                //   AppLocalizations.of(context)!.serviceLocation,
                                //   style: kLightWhiteTextStyle.copyWith(
                                //     fontSize: 16,
                                //     color: ColorRes.empress,
                                //   ),
                                // ),
                                Text(
                                  AppLocalizations.of(context)!.services,
                                  style: kLightWhiteTextStyle.copyWith(
                                    fontSize: 16,
                                    color: ColorRes.empress,
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: bookingsBloc.services.length,
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    Services? service =
                                        bookingsBloc.services[index];
                                    return ItemConfirmService(
                                      service: service,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        top: false,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${AppRes.currency}${bookingsBloc.totalRates()}',
                                      style: kBoldThemeTextStyle,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.subTotal,
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.empress,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 55,
                                  child: TextButton(
                                    style: kButtonThemeStyle,
                                    onPressed: () {
                                      bookingsBloc.clickOnMakePayment();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.continue_,
                                      style: kRegularWhiteTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.bookingsBloc,
  });

  final BookingsBloc bookingsBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
      ),
      color: ColorRes.smokeWhite2,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ((bookingsBloc.addressData.value.name ?? '')).length > 19
                        ? Expanded(
                            child: Text(
                              (bookingsBloc.addressData.value.name ?? ''),
                              style: kMediumThemeTextStyle.copyWith(
                                fontSize: 17,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Text(
                            (bookingsBloc.addressData.value.name ?? ''),
                            style: kMediumThemeTextStyle.copyWith(
                              fontSize: 17,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorRes.lavender,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: ColorRes.themeColor,
                          width: .75,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                      child: Text(
                        AppRes.getAddressTypeInStringFromNumber(
                          bookingsBloc.addressData.value.type?.toInt() ?? 0,
                        ),
                        style: kMediumThemeTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomCircularInkWell(
                      onTap: () async {
                        String iosUrl =
                            'https://maps.apple.com/?q=${bookingsBloc.addressData.value.latitude},${bookingsBloc.addressData.value.longitude}';
                        if (Platform.isAndroid) {
                          String googleUrl =
                              'https://www.google.com/maps/search/?api=1&query=${bookingsBloc.addressData.value.latitude},${bookingsBloc.addressData.value.longitude}';
                          if (await canLaunchUrl(Uri.parse(googleUrl))) {
                            await launchUrl(Uri.parse(googleUrl));
                          } else {
                            throw 'Could not launch $googleUrl';
                          }
                        } else {
                          if (await canLaunchUrl(Uri.parse(iosUrl))) {
                            await launchUrl(Uri.parse(iosUrl));
                          } else {
                            throw 'Could not open the map.';
                          }
                        }
                      },
                      child: Image.asset(
                        AssetRes.icNavigator2,
                        height: 30,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
              CustomCircularInkWell(
                onTap: bookingsBloc.onClickSelectAddress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    border: Border.all(
                      color: ColorRes.empress,
                      width: .75,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.change,
                    style: kMediumTextStyle.copyWith(
                      fontSize: 14,
                      color: ColorRes.empress,
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            bookingsBloc.addressData.value.mobile ?? '',
            style: kMediumThemeTextStyle.copyWith(
              color: ColorRes.empress,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 250,
            child: Text(
              bookingsBloc.addressData.value.address ?? '',
              style: kLightWhiteTextStyle.copyWith(
                color: ColorRes.empress,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemConfirmService extends StatelessWidget {
  final Services? service;

  const ItemConfirmService({
    super.key,
    this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: ColorRes.smokeWhite2,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Row(
          children: [
            SizedBox(
              width: 130,
              height: 110,
              child: FadeInImage.assetNetwork(
                placeholder: '1',
                width: 130,
                height: 110,
                image:
                    '${ConstRes.itemBaseUrl}${service != null && service?.images != null && service!.images!.isNotEmpty ? service!.images![0].image : ''}',
                fit: BoxFit.cover,
                imageErrorBuilder: errorBuilderForImage,
                placeholderErrorBuilder: loadingImage,
              ),
            ),
            Expanded(
              child: Container(
                color: ColorRes.smokeWhite2,
                padding: const EdgeInsets.only(
                  bottom: 5,
                  right: 10,
                  left: 10,
                ),
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      service?.title ?? '',
                      style: kSemiBoldTextStyle.copyWith(
                        color: ColorRes.nero,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${AppRes.currency}${(service?.price?.toInt() ?? 0) - AppRes.calculateDiscountByPercentage(service?.price?.toInt() ?? 0, service?.discount?.toInt() ?? 0).toInt()}',
                                  style: kBoldThemeTextStyle.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    '-',
                                    style: kThinWhiteTextStyle.copyWith(
                                      color: ColorRes.mortar,
                                    ),
                                  ),
                                ),
                                Text(
                                  AppRes.convertTimeForService(
                                      service?.serviceTime?.toInt() ?? 0),
                                  style: kThinWhiteTextStyle.copyWith(
                                    color: ColorRes.mortar,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              AppRes.getGenderTypeInStringFromNumber(
                                  context, service?.gender?.toInt() ?? 0),
                              style: kLightWhiteTextStyle.copyWith(
                                color: ColorRes.empress,
                                fontSize: 12,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        BgRoundImageWidget(
                          onTap: () {
                            BookingsBloc bookingBloc =
                                context.read<BookingsBloc>();
                            bookingBloc
                                .removeService(service?.id?.toInt() ?? -1);
                          },
                          image: AssetRes.icMinus,
                          imagePadding: 11,
                          bgColor: ColorRes.monaLisa,
                          height: 35,
                          width: 35,
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

class ItemStaff extends StatelessWidget {
  const ItemStaff({
    super.key,
    required this.staffData,
    required this.onTapChange,
  });

  final StaffData? staffData;
  final Function() onTapChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: ColorRes.smokeWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: staffData == null
          ? CustomCircularInkWell(
              onTap: onTapChange,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    AppLocalizations.of(context)!.selectBarber,
                    style: kRegularEmpressTextStyle.copyWith(
                      color: ColorRes.darkGray,
                    ),
                  ),
                ),
              ),
            )
          : Row(
              children: [
                ClipOval(
                  child: FadeInImage.assetNetwork(
                    image: '${ConstRes.itemBaseUrl}${staffData?.photo}',
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                    placeholder: AssetRes.icUser,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        height: 75,
                        width: 75,
                        child: errorBuilderForImage(context, error, stackTrace),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            staffData?.name ?? '- - - -',
                            style: kMediumTextStyle.copyWith(
                              fontSize: 17,
                              color: ColorRes.nero,
                            ),
                          ),
                          const Spacer(),
                          CustomCircularInkWell(
                            onTap: onTapChange,
                            child: Text(
                              AppLocalizations.of(context)!.change,
                              style: kRegularTextStyle.copyWith(
                                fontSize: 15,
                                color: ColorRes.themeColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            (staffData?.gender?.toInt() == 1
                                    ? AppLocalizations.of(context)!.male
                                    : AppLocalizations.of(context)!.female)
                                .toUpperCase(),
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.subTitleText,
                              letterSpacing: 1,
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            // decoration: BoxDecoration(
                            //   color: ColorRes.pumpkin15,
                            //   borderRadius: BorderRadius.circular(5),
                            // ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: ColorRes.pumpkin,
                                  size: 16,
                                ),
                                Text(
                                  '${staffData?.rating != null && staffData?.rating != 0 ? staffData?.rating?.toStringAsFixed(1) : (staffData?.rating ?? '0')}',
                                  style: kSemiBoldTextStyle.copyWith(
                                    color: ColorRes.pumpkin,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalOrders,
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.subTitleText,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${staffData?.bookingsCount ?? 0}',
                            style: kBoldThemeTextStyle.copyWith(
                              fontSize: 16,
                              color: ColorRes.nero,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}