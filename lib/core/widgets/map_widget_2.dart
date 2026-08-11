import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final Function(LatLng)? selectedLocation;

  final bool isSelecting;
  final LocationModel initialLocation;

  const MapScreen({
    super.key,
    this.isSelecting = false,
    this.initialLocation = const LocationModel(lat: 35.6783, lon: 51.4161),
    this.selectedLocation,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();

  Future<void> currentLocation() async {
    var locationData = await Location().getLocation();
    setState(() {
      widget.selectedLocation!(
        LatLng(locationData.latitude!, locationData.longitude!),
      );
      mapController.move(
        LatLng(locationData.latitude!, locationData.longitude!),
        16,
      );
    });
  }

  LatLng? _selectedLocation;

  void getSelectedLocation(LatLng position) {
    setState(() {
      _selectedLocation = position;
      widget.selectedLocation!(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                widget.initialLocation.lat,
                widget.initialLocation.lon,
              ),
              initialZoom: 16,
              onTap: (tapPosition, point) {
                if (widget.isSelecting == true) {
                  getSelectedLocation(point);
                }
              },
            ),
            mapController: mapController,
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),

              MarkerLayer(
                markers:
                    (_selectedLocation == null && widget.isSelecting)
                        ? []
                        : [
                          Marker(
                            point:
                                _selectedLocation ??
                                LatLng(
                                  widget.initialLocation.lat,
                                  widget.initialLocation.lon,
                                ),
                            child: Icon(
                              Icons.location_on,
                              color: Colora.primaryColor,
                              size: Dimensions.width * 0.08,
                            ),
                          ),
                        ],
              ),
            ],
          ),

          //current location
          if (widget.isSelecting == true) ...[
            Positioned(
              bottom: Dimensions.height * 0.01,
              right: Dimensions.width * 0.05,
              width: Dimensions.width * 0.1,
              height: Dimensions.height * 0.05,
              child: Container(
                width: Dimensions.width * 0.1,
                height: Dimensions.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colora.primaryColor,
                ),
                child: IconButton(
                  onPressed: () {
                    currentLocation();
                  },
                  icon: Icon(
                    Icons.my_location,
                    color: Colora.scaffold,
                    size: Dimensions.width * 0.05,
                  ),
                ),
              ),
            ),
          ],

          // if(_selectedLocation != null)...[
          //   Positioned(
          //       bottom: Dimensions.height * 0.01,
          //       left: Dimensions.width * 0.05,
          //       width: Dimensions.width * 0.3,
          //       height: Dimensions.height * 0.05,
          //       child: Container(
          //         width: Dimensions.width * 0.3,
          //         height: Dimensions.height * 0.05,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colora.primaryColor
          //         ),
          //         child: InkWell(
          //           onTap: (){},
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               Text(
          //                 'ذخیره',
          //                 style: TextStyle(
          //                   color: Colora.scaffold,
          //                   fontSize: Dimensions.width * 0.03,
          //                 ),
          //               ),
          //               Icon(
          //                 Icons.add_location,
          //                 color: Colora.scaffold,
          //                 size: Dimensions.width * 0.05,
          //               )
          //             ],
          //           ),
          //         ),
          //       )
          //   )
          // ]
        ],
      ),
    );
  }
}
