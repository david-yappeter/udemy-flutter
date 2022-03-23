import 'package:flutter/material.dart';

import 'package:shop_app/providers/product.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductsScreen({Key? key}) : super(key: key);

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void saveForm() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      return;
    }
    if (formKey.currentState != null) {
      formKey.currentState?.save();
    }
    // if (formKey.currentState != null && formKey.currentState!.validate())
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (String? value) {
                  _editedProduct = Product(
                    id: '',
                    title: value as String,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _editedProduct = Product(
                    id: '',
                    title: _editedProduct.title,
                    price: double.parse(value as String),
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (String? value) {
                  _editedProduct = Product(
                    id: '',
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    description: value as String,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (String? value) {
                        _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: value as String,
                        );
                      },
                      validator: (String? url) {
                        if (url != null && url.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (url != null && !url.startsWith('http')) {
                          return 'Please enter a valid URL';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
