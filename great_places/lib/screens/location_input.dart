import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function(PlaceLocation) onLocationSelect;
  const LocationInput({Key? key, required this.onLocationSelect})
      : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _previewLocation;

  Future<String> getAddress(double latitude, double longitude) async {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(latitude, longitude);
    geocoding.Placemark place = placemarks[0];
    return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final addressName = await getAddress(
        locData.latitude as double, locData.longitude as double);
    setState(() {
      _previewLocation = PlaceLocation(
        latitude: locData.latitude as double,
        longitude: locData.longitude as double,
        address: addressName,
      );
    });

    widget.onLocationSelect(_previewLocation as PlaceLocation);
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext ctx) => MapScreen(
          initialLocation: PlaceLocation(
            latitude: locData.latitude as double,
            longitude: locData.longitude as double,
          ),
          isSelecting: true,
        ),
      ),
    ) as PlaceLocation?;

    if (selectedLocation == null) return;

    setState(() {
      _previewLocation = selectedLocation;
    });
    final addressName = await getAddress(
        locData.latitude as double, locData.longitude as double);
    widget.onLocationSelect(PlaceLocation(
      latitude: _previewLocation?.latitude as double,
      longitude: _previewLocation?.longitude as double,
      address: addressName,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          child: _previewLocation == null
              ? const Text('No Location Chosen', textAlign: TextAlign.center)
              : LocationHelper.generateMap(_previewLocation as PlaceLocation),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentUserLocation,
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: _selectOnMap,
              label: const Text('Location'),
            ),
          ],
        ),
      ],
    );
  }
}
