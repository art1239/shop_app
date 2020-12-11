import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/MuttableProduct.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class AddEditProduct extends StatefulWidget {
  static const path = '/addOrEdit';

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final _imageUrlController = TextEditingController();
  final _imgFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String title = 'Add';
  var isCalledForTheFirstTime = true;
  final editedProduct =
      MuttableProduct(title: '', price: 0.0, desc: '', id: null, imageUrl: '');
  @override
  void initState() {
    _imgFocus.addListener(() => _updateListener());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (isCalledForTheFirstTime) {
    print('U therrit change dependecies');
    String id = ModalRoute.of(context).settings.arguments as String;

    if (id != null) {
      title = 'Edit';
      final initialProduct = Provider.of<Products>(context).findItemById(id);
      editedProduct.desc = initialProduct.description;
      _imageUrlController.text = initialProduct.imageUrl;
      editedProduct.price = initialProduct.price;
      editedProduct.title = initialProduct.title;
      editedProduct.id = initialProduct.id;
      editedProduct.isFavorite = initialProduct.isFavorite;
    }

    // }
    // isCalledForTheFirstTime = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgFocus.removeListener(_updateListener);
    _imgFocus.dispose();
    _imageUrlController.dispose();

    super.dispose();
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState.save();
    if (editedProduct.id != null) {
      Product productToBeUpdated = Product(
          id: editedProduct.id,
          title: editedProduct.title,
          price: editedProduct.price,
          description: editedProduct.desc,
          imageUrl: editedProduct.imageUrl,
          isFavorite: editedProduct.isFavorite);

      Provider.of<Products>(context, listen: false)
          .modifyProduct(productToBeUpdated, productToBeUpdated.id);
    } else {
      Product productToBeAdded = Product(
          id: DateTime.now().toString(),
          title: editedProduct.title,
          price: editedProduct.price,
          description: editedProduct.desc,
          imageUrl: editedProduct.imageUrl,
          isFavorite: editedProduct.isFavorite);

      Provider.of<Products>(context, listen: false)
          .addProducts(productToBeAdded);
    }

    Navigator.of(context).pop();
  }

  void _updateListener() {
    if (!_imgFocus.hasFocus) {
      if (!isImageUrlValid()) {
        return;
      }
      setState(() {});
    }
  }

  bool isImageUrlValid() {
    var startsWithProtocolHttpProtocol = _imageUrlController.text.startsWith(
      RegExp('https?'),
    );
    var endsWithAnImagePostfix = _imageUrlController.text.endsWith('.png') ||
        _imageUrlController.text.endsWith('.jpeg') ||
        _imageUrlController.text.endsWith('.jpg');

    return (startsWithProtocolHttpProtocol && endsWithAnImagePostfix);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            TextFormField(
              initialValue: editedProduct.title,
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                editedProduct.title = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'No empty values allowed';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: editedProduct.price.toString(),
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                editedProduct.price = double.parse(value);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Null values not allowed';
                } else if (double.tryParse(value) == null) {
                  return 'Enter a valid number please';
                } else if (double.parse(value) <= 0) {
                  return 'Enter a number greater than 0';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: editedProduct.desc,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              onSaved: (value) {
                editedProduct.desc = value.trim();
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'No empty values allowed';
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
                  margin: EdgeInsets.only(top: 10, right: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Container(
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imgFocus,
                    validator: (value) {
                      if (!isImageUrlValid()) {
                        return 'Enter a valid image';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    onSaved: (value) {
                      editedProduct.imageUrl = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Image',
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
