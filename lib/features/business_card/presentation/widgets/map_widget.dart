import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/business_card/presentation/bloc/business_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if (state.status == CWSStatus.loading) {
            return const CircularProgressIndicator();
          } else if (state.status == CWSStatus.loading) {
            final selectedLocation = state.location;
            return _buildMap(selectedLocation, context, state);
          } else if (state.status == CWSStatus.initial) {
            return _buildMap(const LatLng(0, 0), context, state);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildMap(LatLng selectedLocation, BuildContext context, state) {
    final locationBloc = context.read<BusinessBloc>();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter:
                  selectedLocation == const LatLng(0, 0)
                      ? const LatLng(35.6783, 51.4161)
                      : selectedLocation,
              initialZoom: 18,
              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureRace: true,
              ),
              onPositionChanged: (_, __) {
                if (state.status == CWSStatus.loading) {
                  //locationBloc.add(UpdateLocationEvent(locationBloc.mapController.center));
                }
              },
              onTap: ((tapPosition, point) {
                if (locationBloc.state.status == CWSStatus.loading) {
                  locationBloc.add(DetermineCurrentPosition());
                }
              }),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  if (locationBloc.state.status == CWSStatus.loading)
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      child: const Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.red,
                      ),
                      point: selectedLocation,
                    ),
                  if (locationBloc.state.status == CWSStatus.loading)
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: selectedLocation,
                      child: const Icon(
                        Icons.pin_drop,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () async {
                      Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );
                      double lat = position.latitude;
                      double long = position.longitude;

                      LatLng location = LatLng(lat, long);
                      locationBloc.add(UpdateSelectedLocation(location));
                    },
                  ),
                ],
              ),
            ],
          ),
          // Positioned(
          //   bottom: 16,
          //   left: 16,
          //   child: GestureDetector(
          //     onTap: () {
          //       if (state.status == Status.loaded) {
          //         locationBloc.add(DetermineCurrentPosition());
          //       } else {
          //         locationBloc.add(SaveLocation());
          //       }
          //     },
          //     child: Container(
          //       height: 30,
          //       width: 100,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         color: locationBloc.state.status == Status.loaded
          //             ? Colors.red
          //             : Colors.green,
          //       ),
          //       child: Center(
          //         child: Text(
          //           locationBloc.state.status == Status.loaded
          //               ? "تغییر لوکیشن"
          //               : "ذخیره لوکیشن",
          //           style: const TextStyle(color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
