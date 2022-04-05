import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

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
                      onSaved: (String? val) {},
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
                    ImageInput(),
                  ],
                ),
              ),
            ),
          )),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {},
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
