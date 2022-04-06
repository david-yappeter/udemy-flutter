import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/location_input.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _value = {
    "title": null,
  };
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  Future<void> _selectLocation(PlaceLocation pickedLocation) async {
    _pickedLocation = pickedLocation;
    if (_pickedLocation == null) return;
  }

  void _savePlace() {
    if (_formKey.currentState == null ||
        _pickedImage == null ||
        _pickedLocation == null) return;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    Provider.of<GreatPlaces>(context, listen: false).add(_value['title'],
        _pickedImage as File, _pickedLocation as PlaceLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (String? val) {
                        _value['title'] = val;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter a valid title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                    const SizedBox(height: 10),
                    LocationInput(onLocationSelect: _selectLocation),
                  ],
                ),
              ),
            ),
          )),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: _savePlace,
            label: const Text(
              'Add Place',
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
