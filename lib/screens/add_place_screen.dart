import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../providers/great_places_providers.dart';
import '../widgets/image_input_builder.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  late File _pickedImage;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty) // || _pickedImage == null
    {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInputBuilder(onSelectImage: _selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // this helps to make the button on the end of the screen
            color: Colors.blue,
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
