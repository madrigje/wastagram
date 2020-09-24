import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:location/location.dart';
import 'package:wastagram/models/fields.dart';

class WastagramEntry extends StatefulWidget {
  @override
  _WastagramEntryState createState() => _WastagramEntryState();
}

class _WastagramEntryState extends State<WastagramEntry> {
  Fields fields;
  PickedFile image;
  LocationData locationData;
  String url;
  File _image;
  final picker = ImagePicker();

  final formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Scaffold(
          body: Center(
              child: Semantics(
        selected: true,
        enabled: true,
        onTapHint: 'Select a Photo',
        child: RaisedButton(
          child: Text('Select a Photo'),
          onPressed: () {
            getImage();
          },
        ),
      )));
    } else {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image.file(_image),
              numberField(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  shareButton(context),
                ],
              ),
            ]),
          ));
    }
  }

  Widget numberField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: numberController,
        keyboardType: TextInputType.text,
        autofocus: true,
        decoration: InputDecoration(
            labelText: 'Total Items', border: OutlineInputBorder()),
        onSaved: (value) {
          FirebaseFirestore.instance.collection('list').add({
            'Total': int.parse(value),
            'Date': DateTime.now(),
            'Picture': url,
            'longitude': locationData.longitude,
            'latitude': locationData.latitude
          });
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a total';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget shareButton(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          Navigator.of(context).pop();
        }
      },
      color: Color.fromARGB(200, 153, 0, 0),
      highlightColor: Color.fromARGB(255, 160, 160, 160),
      child: Semantics(
        selected: true,
        enabled: true,
        onTapHint: 'Upload all work!',
        child: Text('Upload')
      ),
    );
  }

  Future getImage() async {
    image = await picker.getImage(source: ImageSource.gallery);
    _image = File(image.path);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(Path.basename(DateTime.now().toString()));
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
    setState(() {});
  }

  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }
}
