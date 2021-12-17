import 'package:flutter/material.dart';
import '../models/place_model.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [...items];
  }
}
