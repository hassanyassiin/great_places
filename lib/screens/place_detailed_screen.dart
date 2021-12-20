import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_providers.dart';
import 'map_screen.dart';

class PlaceDetailedScreen extends StatelessWidget {
  const PlaceDetailedScreen({Key? key}) : super(key: key);
  static const routeName = '/place-detailed';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectPlace =
        Provider.of<GreatPlaces>(context, listen: false).placeById('id');//todo the id should not be in string
    return Scaffold(
      appBar: AppBar(
        title: Text(selectPlace.title),
      ),
      body: Column(
        children: <Widget>[
           SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectPlace.location!.address,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectPlace.location!,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: const Text('View on Map'),
          ),
        ],
      ),
    );
  }
}
