import 'package:flutter/material.dart';

class AddEditProduct extends StatefulWidget {
  static const path = '/addOrEdit';
  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final _imageUrlController = TextEditingController();
  final _imgFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _imgFocus.addListener(() => _updateListener());
    super.initState();
  }

  @override
  void dispose() {
    _imgFocus.removeListener(_updateListener);
    _imgFocus.dispose();
    _imageUrlController.dispose();

    super.dispose();
  }

  void _saveForm() {
    _formKey.currentState.save();
  }

  void _updateListener() {
    if (!_imgFocus.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
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
                    onFieldSubmitted: (_) {
                      _saveForm();
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
