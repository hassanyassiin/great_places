import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../screens/places_list_screen.dart';
import '../screens/add_place_screen.dart';
import '../providers/great_places_providers.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great places',
        debugShowCheckedModeBanner: false,
        home: const PlacesScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
