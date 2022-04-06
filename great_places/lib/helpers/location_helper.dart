import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_places/models/place.dart';
import 'package:latlong2/latlong.dart';

class LocationMap extends StatefulWidget {
  final PlaceLocation? location;
  final bool isSelecting;
  final Function(PlaceLocation)? callback;
  const LocationMap(
      {Key? key,
      required this.location,
      required this.isSelecting,
      this.callback})
      : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  LatLng? centerVal;

  void updateLocationFromWidget() {
    centerVal = widget.location == null
        ? null
        : LatLng(widget.location!.latitude, widget.location!.longitude);
  }

  @override
  void initState() {
    super.initState();
    updateLocationFromWidget();
  }

  @override
  void didUpdateWidget(covariant LocationMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateLocationFromWidget();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: centerVal,
        zoom: 13.0,
        onTap: (tapPos, latlng) {
          if (!widget.isSelecting) return;
          if (widget.callback != null) {
            widget.callback!(
              PlaceLocation(
                latitude: latlng.latitude,
                longitude: latlng.longitude,
              ),
            );
          }
          setState(() {
            centerVal = LatLng(latlng.latitude, latlng.longitude);
          });
        },
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return const Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            if (centerVal != null)
              Marker(
                width: 100.0,
                height: 100.0,
                point: centerVal as LatLng,
                builder: (ctx) => const Icon(Icons.location_on,
                    color: Colors.red, size: 50.0),
              ),
          ],
        ),
      ],
    );
  }
}

class LocationHelper {
  static Widget generateMap(
    PlaceLocation location, {
    bool isSelecting = false,
    Function(PlaceLocation)? callback,
  }) {
    return LocationMap(
      location: location,
      isSelecting: isSelecting,
      callback: callback,
    );
  }
}
