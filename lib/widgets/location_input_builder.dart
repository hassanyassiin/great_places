import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/map_screen.dart';
import '../helpers/location_helpers.dart';

class LocationInput extends StatefulWidget {
  final Function? onSelectPlace;
  const LocationInput({Key? key, required this.onSelectPlace})
      : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(
      () {
        _previewImageUrl = staticMapImageUrl;
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.longitude!, locData.longitude!);
      widget.onSelectPlace!(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectingOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.longitude, selectedLocation.longitude);
    widget.onSelectPlace!(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen!',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              textColor: Colors.black,
              onPressed: _getCurrentLocation,
            ),
            FlatButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              textColor: Colors.black,
              onPressed: _selectingOnMap,
            ),
          ],
        )
      ],
    );
  }
}
