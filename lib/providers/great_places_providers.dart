import 'package:flutter/material.dart';
import '../models/place_model.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
   final List<Place> _items = [
   ];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String newTitle, File newImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: newTitle,
        image: newImage,
        location: null);
    _items.add(newPlace);
    notifyListeners();
  }
}
