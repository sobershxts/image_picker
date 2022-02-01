// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:io';
import 'dart:async';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: FImagePicker()
  ));
}

class FImagePicker extends StatefulWidget {
  const FImagePicker({Key? key}) : super(key: key);

  @override
  _FImagePickerState createState() => _FImagePickerState();

  pickImage({source = ImageSource}) {}
}

class _FImagePickerState extends State<FImagePicker> {
  late File _image;
  final FImagePicker _picker = FImagePicker();
  Future getImage(ImageSource source) async {
    File? pickedFile = await _picker.pickImage(source: source);
    // ignore: unnecessary_null_comparison
    if (_image == null) return;

    final imageTemporary = File(_image.path);

    setState(() {
      _image = pickedFile!;
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context,
                        FImagePicker().pickImage(source: ImageSource.camera));
                  },
                  child: const Text('Camera'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context,
                        FImagePicker().pickImage(source: ImageSource.gallery));
                  },
                  child: const Text('Gallery'),
                )
              ],
              title: const Text('Edit Profile'),
              contentPadding: const EdgeInsets.all(20.0),
              content:
              const Text('Take a picture or choose one from your library'),
            ),
          );
        },
      ),
    );
  }
}