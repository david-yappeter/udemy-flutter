import 'package:flutter/material.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-select';

  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapScreen({
    Key? key,
    required this.initialLocation,
    this.isSelecting = false,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation? currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = widget.initialLocation;
  }

  void changeLocation(PlaceLocation location) {
    currentLocation = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(currentLocation);
              },
            ),
        ],
      ),
      body: LocationHelper.generateMap(
        widget.initialLocation,
        isSelecting: widget.isSelecting,
        callback: changeLocation,
      ),
    );
  }
}
