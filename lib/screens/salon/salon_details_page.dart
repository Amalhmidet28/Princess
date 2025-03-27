import 'dart:io';
import 'package:cutfx/bloc/salon/salon_details_bloc.dart';
import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SalonDetailsPage extends StatelessWidget {
  const SalonDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SalonDetailsBloc salonDetailsBloc = context.read<SalonDetailsBloc>();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorRes.themeColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Handle booking action
          },
          child: Text(
            "Book Now",
            style:
                kSemiBoldTextStyle.copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                salonDetailsBloc.salonData?.salonAbout ?? '',
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.empress,
                  fontSize: 16,
                ),
              ),
            ),
          
            _buildWorkingHoursSection(context, salonDetailsBloc),
            _buildContactSection(context, salonDetailsBloc),
            _buildMapSection(context, salonDetailsBloc),
          ],
        ),
      ),
    );
  }

 




  Widget _buildWorkingHoursSection(
      BuildContext context, SalonDetailsBloc salonDetailsBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Working Hours", style: kSemiBoldThemeTextStyle),
          _buildTimeRow(
              "Monday - Friday",
              salonDetailsBloc.salonData?.monFriFrom,
              salonDetailsBloc.salonData?.monFriTo),
          _buildTimeRow(
              "Saturday - Sunday",
              salonDetailsBloc.salonData?.satSunFrom,
              salonDetailsBloc.salonData?.satSunTo),
        ],
      ),
    );
  }

  Widget _buildTimeRow(String day, String? from, String? to) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day,
            style: kLightWhiteTextStyle.copyWith(color: ColorRes.empress)),
        Text(
            "${AppRes.convert24HoursInto12Hours(from)} - ${AppRes.convert24HoursInto12Hours(to)}",
            style: kSemiBoldTextStyle),
      ],
    );
  }

  Widget _buildContactSection(
      BuildContext context, SalonDetailsBloc salonDetailsBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Contact Us", style: kSemiBoldThemeTextStyle),
          GestureDetector(
            onTap: () => launchUrl(
                Uri.parse('tel:${salonDetailsBloc.salonData?.salonPhone}')),
            child: Text("+${salonDetailsBloc.salonData?.salonPhone ?? ''}",
                style: kLightWhiteTextStyle.copyWith(color: const Color.fromARGB(255, 198, 136, 83))),
          ),
        ],
      ),
    );
  } 

  Widget _buildMapSection(BuildContext context, SalonDetailsBloc salonDetailsBloc) {
  return AspectRatio(
    aspectRatio: 1 / .6,
    child: Stack(
      children: [
        GMapDetails(salon: salonDetailsBloc.salonData),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Our Adresses",  // Title text for the section
              style: kSemiBoldThemeTextStyle.copyWith(
                fontSize: 18, 
                color: ColorRes.empress, // Adjust this color to fit your theme
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: CustomCircularInkWell(
            onTap: () async {
              String iosUrl =
                  'https://maps.apple.com/?q=${salonDetailsBloc.salonData?.salonLat},${salonDetailsBloc.salonData?.salonLong}';
              if (Platform.isAndroid) {
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=${salonDetailsBloc.salonData?.salonLat},${salonDetailsBloc.salonData?.salonLong}';
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Container(
                  color: ColorRes.themeColor, // Adjust this to match the color from the screenshot
                  width: 150,
                  height: 45,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,  // Location pin icon
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.seeOnMaps,  // Ensure the localization key is correct
                          style: kRegularWhiteTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}

extension on AppLocalizations {
  String get seeOnMaps => seeOnMaps;
}

class GMapDetails extends StatefulWidget {
  const GMapDetails({
    super.key,
    required this.salon,
  });

  final SalonData? salon;

  @override
  State<GMapDetails> createState() => _GMapDetailsState();
}

class _GMapDetailsState extends State<GMapDetails> {
  BitmapDescriptor? bitmapDescriptor;
  Set<Marker> markers = {};
  late String mapStyle;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return widget.salon != null
        ? GoogleMap(
            initialCameraPosition: CameraPosition(
              // target: LatLng(
              //   double.parse(widget.salon?.data?.salonLat ?? '0'),
              //   double.parse(widget.salon?.data?.salonLong ?? '0'),
              // ),
              target: LatLng(
                double.parse(widget.salon?.salonLat ?? '0'),
                double.parse(widget.salon?.salonLong ?? '0'),
              ),
              zoom: 12,
            ),
            onTap: null,
            onMapCreated: (controller) {
              if (bitmapDescriptor == null) {
                initBitmap(controller);
              }
            },
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            buildingsEnabled: true,
            markers: markers,
            scrollGesturesEnabled: false,
          )
        : const SizedBox();
  }

  void initBitmap(GoogleMapController controller) async {
    mapStyle = await rootBundle.loadString('images/map_style.json');
    bitmapDescriptor = await BitmapDescriptor.asset(
        ImageConfiguration(
            size: Platform.isAndroid ? const Size(24, 24) : const Size(15, 15)),
        Platform.isAndroid ? AssetRes.icPinAnd : AssetRes.icPin);
    markers = Set.of(List.generate(1, (index) {
      return Marker(
        markerId: const MarkerId('q'),
        position: LatLng(
          double.parse(widget.salon?.salonLat ?? '0'),
          double.parse(widget.salon?.salonLong ?? '0'),
        ),
        icon: bitmapDescriptor!,
      );
    }));
    // controller.setMapStyle(mapStyle);
    setState(() {});
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}

