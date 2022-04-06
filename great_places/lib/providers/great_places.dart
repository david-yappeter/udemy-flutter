import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _nodes = [];

  List<Place> get nodes {
    return [..._nodes];
  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData('places');
    _nodes = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(
                item['image'],
              ),
              location: PlaceLocation(
                latitude: item['latitude'] as double,
                longitude: item['longitude'] as double,
                address: item['location'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  void add(
    String title,
    File image,
    PlaceLocation location,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: location,
    );
    _nodes.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'longitude': newPlace.location!.longitude,
        'latitude': newPlace.location!.latitude,
        'location': newPlace.location!.address,
      },
    );
  }

  Place findById(String id) {
    return _nodes.firstWhere((place) => place.id == id);
  }
}
