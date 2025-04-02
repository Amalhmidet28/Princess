import 'package:cutfx/bloc/salon/salon_details_bloc.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/booking/confirm_booking.dart';
import 'package:cutfx/screens/login/login_option_screen.dart';
import 'package:cutfx/screens/notification/notification_screen.dart';
import 'package:cutfx/screens/service/service_detail_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class SalonServicesPage extends StatelessWidget {
  const SalonServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SalonDetailsBloc salonDetailsBloc = context.read<SalonDetailsBloc>();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllCategoriesScreen(
                          categories: salonDetailsBloc.categories,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "See All",
                    style: TextStyle(
                        color: ColorRes.themeColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: salonDetailsBloc.categories.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final category = salonDetailsBloc.categories[index];
                return ServiceCard(category: category);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorRes.themeColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (salonDetailsBloc.totalRates() == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please select at least one service to book.')),
                  );
                  return;
                }

                if (ConstRes.userIdValue == -1) {
                  Get.to(() => const LoginOptionScreen());
                  return;
                }

                Get.to(
                  () => const ConfirmBookingScreen(),
                  arguments: {
                    ConstRes.salonData: salonDetailsBloc.salonData,
                    ConstRes.services: salonDetailsBloc.selectedServices,
                  },
                );
              },
              child: const Text('Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class AllCategoriesScreen extends StatelessWidget {
  final List<Categories> categories;

  AllCategoriesScreen({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Services"),
        actions: [
          IconButton(
            icon: Image.asset(AssetRes.icNotification), // Custom icon
            onPressed: () {
              Get.to(() => const NotificationScreen());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(category: category);
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Categories category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AllServicesScreen(services: category.services),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      category.title ?? 'No Title',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 240), 
                    Text(
                      "${category.services?.length ?? 0} types",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 18, color: Colors.brown),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Categories category;

  const ServiceCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, 
          children: [
            Text(
              category.title ?? 'No Title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "${category.services?.length ?? 0} types",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Navigate to AllServicesScreen with actual services
          Get.to(
            () => AllServicesScreen(services: category.services),
          );
        },
      ),
    );
  }
}

class AllServicesScreen extends StatelessWidget {
  final List<Services>? services;

  const AllServicesScreen({super.key, this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorRes.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(AssetRes.icNotification),
            onPressed: () {
              Get.to(() => const NotificationScreen());
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: ColorRes.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: services?.length ?? 0,
          itemBuilder: (context, index) {
            Services? service = services?[index];

            return GestureDetector(
              onTap: () {
                Get.to(
                  () => const ServiceDetailScreen(),
                  arguments: service?.id?.toInt() ?? -1,
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    service?.title ?? 'Service Name',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorRes.black,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: ColorRes.themeColor),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
