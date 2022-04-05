import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _nodes = [];

  List<Place> get nodes {
    return [..._nodes];
  }

  void fetchAndSet() {
    notifyListeners();
  }

  void add(Place node) {
    _nodes.add(node);
    notifyListeners();
  }
}
