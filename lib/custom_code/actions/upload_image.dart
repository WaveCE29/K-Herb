// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

getImage(BuildContext context) async {}

Future<String> uploadImage(BuildContext context) async {
  bool? isCamera = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Camera"),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Gallery"),
          ),
        ],
      ),
    ),
  );
  // Add your function code here!
  String error = "";
  if (isCamera == null) return 'exit';
  try {
    final XFile? photoURL = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (photoURL != null) {
      FFAppState().uploadedImage = photoURL.path;
      return photoURL.path;
    }
  } catch (e) {
    error = e.toString();
  }

  return error;
}
