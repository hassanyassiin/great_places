import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'dart:io';

class ImageInputBuilder extends StatefulWidget {
  final Function onSelectImage;
  const ImageInputBuilder({Key? key,required this.onSelectImage}) : super(key: key);


  @override
  _ImageInputBuilderState createState() => _ImageInputBuilderState();
}

class _ImageInputBuilderState extends State<ImageInputBuilder> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if(imageFile == null)
      {
        return;
      }

    setState(
      () {
        _storedImage = File(imageFile.path);
      },
    );
    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImage =
        await _storedImage!.copy('${appDirectory.path}/$fileName');
    widget.onSelectImage(saveImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const FittedBox(
                  child: Text('No Image Taken'),
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Pic'),
            textColor: Colors.black,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
