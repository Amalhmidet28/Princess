import 'package:cutfx/bloc/notification/notification_bloc.dart';
import 'package:cutfx/model/notification/notification.dart';
import 'package:cutfx/screens/fav/favourite_screen.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: ColorRes.black,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),const SizedBox(width: 1),
                  Text(
                    AppLocalizations.of(context)!.notifications,
                    style: kRegularTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                  Row(
                    children: [
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
                      Material(
                        color: Colors.transparent,
                        child: BgRoundImageWidget(
                          image: AssetRes.icNotification,
                          imageColor: ColorRes.bistreBrown, 
                          backgroundColor: ColorRes.bistreBrown.withOpacity(0.2),
                          imagePadding: 9,
                          onTap: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ),
           BlocBuilder<NotificationBloc, NotificationState>(
  builder: (context, state) {
    NotificationBloc notificationBloc = context.read<NotificationBloc>();

    List<Data> sortedNotifications = List.from(notificationBloc.notifications)
      ..sort((a, b) {
        DateTime aDate = DateTime.parse(a.createdAt ?? '1970-01-01T00:00:00Z');
        DateTime bDate = DateTime.parse(b.createdAt ?? '1970-01-01T00:00:00Z');
        return bDate.compareTo(aDate);
      });

    Map<String, List<Data>> groupedNotifications = {};

    // Regrouper les notifications par catégorie
    for (var notification in sortedNotifications) {
      DateTime notificationDate = DateTime.parse(notification.createdAt ?? '1970-01-01T00:00:00Z');
      String category = _getCategory(notification);  // Utilisez _getCategory avec la notification
      if (!groupedNotifications.containsKey(category)) {
        groupedNotifications[category] = [];
      }
      // Ajoutez la notification au groupe correspondant
      groupedNotifications[category]!.add(notification);
    }

    // Le reste du code pour afficher les notifications
    return state is NotificationInitial
        ? const Expanded(child: LoadingData(color: ColorRes.white))
        : sortedNotifications.isNotEmpty
            ? Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  children: groupedNotifications.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: kRegularTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        ...entry.value.map((notification) => _buildNotificationCard(notification)),
                        const SizedBox(height: 15),
                      ],
                    );
                  }).toList(),
                ),
              )
            : const Expanded(child: Center(child: DataNotFound()));
  },
)
])));
  }

String _getCategory(Data notification) {
  DateTime now = DateTime.now();
  // Convertir la chaîne `createdAt` en DateTime
  DateTime createdAtDate = DateTime.parse(notification.createdAt ?? '1970-01-01T00:00:00Z');

  // Comparer la date de création avec la date actuelle
  if (DateFormat('yyyy-MM-dd').format(createdAtDate) == DateFormat('yyyy-MM-dd').format(now)) {
    return "Today";
  } else if (DateFormat('yyyy-MM-dd').format(createdAtDate) ==
      DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)))) {
    return "Yesterday";
  } else {
    return DateFormat('MMMM dd, yyyy').format(createdAtDate);
  }
}



  Widget _buildNotificationCard(Data notification) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 6,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(notification.type),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title ?? '',
                style: kRegularTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification.description ?? '',
                style: kLightWhiteTextStyle.copyWith(
                  color: const Color.fromARGB(255, 9, 9, 9),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildIcon(String? type) {
    IconData icon;
    Color bgColor;

    switch (type) {
      case 'payment':
        icon = Icons.payment;
        bgColor = Colors.brown;
        break;
      case 'service':
        icon = Icons.add_circle;
        bgColor = Colors.red;
        break;
      case 'offer':
        icon = Icons.local_offer;
        bgColor = Colors.pink;
        break;
      case 'credit_card':
        icon = Icons.credit_card;
        bgColor = Colors.blue;
        break;
      case 'account':
        icon = Icons.account_circle;
        bgColor = Colors.green;
        break;
      default:
        icon = Icons.notifications;
        bgColor = const Color.fromARGB(255, 207, 114, 8);
        break;
    }

    return CircleAvatar(
      backgroundColor: bgColor.withOpacity(0.2),
      radius: 24,
      child: Icon(icon, color: bgColor, size: 28),
    );
  }
}
