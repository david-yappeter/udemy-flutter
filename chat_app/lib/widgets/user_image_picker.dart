import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File? pickedImage) imagePickerFn;

  const UserImagePicker({
    Key? key,
    required this.imagePickerFn,
  }) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() {
    final imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.camera).then((XFile? image) {
      setState(() {
        _pickedImage = image == null ? null : File(image.path);
      });
      widget.imagePickerFn(_pickedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage as File),
          radius: 30.0,
          // child: _pickedImage == null ? null : Image.file(_pickedImage as File),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
