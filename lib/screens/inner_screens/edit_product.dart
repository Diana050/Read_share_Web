import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _catValue;
  late final TextEditingController _titleController,
      _authorController,
      _descriptionController,
      _priceController;

  late bool _isHot;
  File? _pickedImage;
  Uint8List webImage = Uint8List(10);
  late String _imageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    _priceController = TextEditingController(text: '');
    _titleController = TextEditingController(text: '');
    _authorController = TextEditingController(text: '');
    _descriptionController = TextEditingController(text: '');

    _catValue = 'Romance Books';
    _isHot = false;
    _imageUrl = ''; //pune un link aici

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _priceController.dispose();
      _titleController.dispose();
      _authorController.dispose();
      _descriptionController.dispose();
    }
    super.dispose();
  }

  void _updateProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
