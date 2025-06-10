import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:read_share_disertatie_web/consts/constants.dart';
import 'package:read_share_disertatie_web/controllers/MenuController.dart';
import 'package:read_share_disertatie_web/responsive.dart';
import 'package:read_share_disertatie_web/screens/loading_manager.dart';
import 'package:read_share_disertatie_web/services/global_method.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/buttons.dart';
import 'package:read_share_disertatie_web/widgets/header.dart';
import 'package:read_share_disertatie_web/widgets/side_menu.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';
import 'package:uuid/uuid.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';
  const UploadProductForm({Key? key}) : super(key: key);

  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  String _catValue = 'Romance Books';
  late final TextEditingController _titleController,
      _authorController,
      _descriptionController,
      _priceController;
  int _groupValue = 1;
  // bool isPiece = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _descriptionController = TextEditingController();

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

  bool _isLoading = false;

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    String? imageUrl;
    if (isValid) {
      _formKey.currentState!.save();
      if (_pickedImage == null) {
        GlobalMethods.errorDialog(
          subtitle: 'Please pick up an image',
          context: context,
        );
        return;
      }
      final _uuid = const Uuid().v4();
      try {
        setState(() {
          _isLoading = true;
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('productImages')
            .child('$_uuid.jpg');
        if (kIsWeb) {
          await ref.putData(webImage);
        } else {
          await ref.putFile(_pickedImage!);
        }
        imageUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('products').doc(_uuid).set({
          'id': _uuid,
          'title': _titleController.text,
          'author': _authorController.text,
          'description': _descriptionController.text,
          'price': _priceController.text,
          'imageUrl': imageUrl,
          'productCategoryName': _catValue,
          'isHot': false,
          'createdAt': Timestamp.now(),
        });
        _clearForm();
        Fluttertoast.showToast(
          msg: 'Title added successfully!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
        );
      } on FirebaseException catch (error) {
        //print('an error occured $error');
        GlobalMethods.errorDialog(
          subtitle: '${error.message}',
          context: context,
        );
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        //print('an error occured $error');
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearForm() {
    // isPiece = false;
    _groupValue = 1;
    _titleController.clear();
    _authorController.clear();
    _descriptionController.clear();
    _priceController.clear();
    setState(() {
      _pickedImage = null;
      webImage = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).screenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
      ),
    );
    return Scaffold(
      key: context.read<Menucontroller>().getAddProductscaffoldKey,
      drawer: const SideMenu(),
      body: LoadingManager(
        isLoading: _isLoading,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(child: SideMenu()),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      fct: () {
                        context.read<Menucontroller>().controlAddProductsMenu();
                      },
                      title: 'Add Products',
                      showText: false,
                    ),
                    Container(
                      width: size.width > 650 ? 650 : size.width,
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextWidget(
                              text: 'Book Title*',
                              color: color,
                              textSize: 18,
                              isTitle: true,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _titleController,
                              key: const ValueKey('Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            ),
                            const SizedBox(height: 20),
                            TextWidget(
                              text: 'Author*',
                              color: color,
                              textSize: 18,
                              isTitle: true,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _authorController,
                              key: const ValueKey('Author'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the author\'s name';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            ),
                            const SizedBox(height: 20),
                            TextWidget(
                              text: 'Description*',
                              color: color,
                              textSize: 18,
                              isTitle: true,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _descriptionController,
                              key: const ValueKey('Description'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a description';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: 'Number of days',
                                        color: color,
                                        textSize: 18,
                                        isTitle: true,
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: TextFormField(
                                          controller: _priceController,
                                          key: const ValueKey('Days'),
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter the number of days';
                                            }
                                            return null;
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9.]'),
                                            ),
                                          ],
                                          decoration: inputDecoration,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ), // smaller input text
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextWidget(
                                        text: 'Product Category',
                                        color: color,
                                        textSize: 18,
                                        isTitle: true,
                                      ),
                                      const SizedBox(height: 10),
                                      //drop down menu
                                      _categoryDropDown(),
                                    ],
                                  ),
                                ),
                                //image to be picked
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                          size.width > 650
                                              ? 350
                                              : size.width *
                                                  0.45, //try other values
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(
                                              context,
                                            ).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                      ),
                                      child:
                                          _pickedImage == null
                                              ? dottedBorder(color: color)
                                              : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child:
                                                    kIsWeb
                                                        ? Image.memory(
                                                          webImage,
                                                          fit: BoxFit.fill,
                                                        )
                                                        : Image.file(
                                                          _pickedImage!,
                                                          fit: BoxFit.fill,
                                                        ),
                                              ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _pickedImage = null;
                                            webImage = Uint8List(8);
                                          });
                                        },
                                        child: TextWidget(
                                          text: 'Clear',
                                          color: Colors.red,
                                          textSize: 16,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: TextWidget(
                                          text: 'Update Image',
                                          color: Colors.lightBlue,
                                          textSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonsWidget(
                                    onPressed: _clearForm,
                                    text: 'Clear Form',
                                    icon: IconlyBold.danger,
                                    backgroundColor: Colors.red.shade300,
                                  ),
                                  ButtonsWidget(
                                    onPressed: _uploadForm,
                                    text: 'Upload',
                                    icon: IconlyBold.upload,
                                    backgroundColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dottedBorder({required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        dashPattern: const [6.7],
        borderType: BorderType.RRect,
        color: color,
        radius: Radius.circular(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.image_outlined, color: color, size: 50),
              TextButton(
                onPressed: () {
                  _pickImage();
                },
                child: TextWidget(
                  text: 'Choose an image',
                  color: color,
                  textSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  Widget _categoryDropDown() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      //padding: const EdgeInsets.all(5.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _catValue,
          onChanged: (value) {
            setState(() {
              _catValue = value!;
            });
            print(_catValue);
          },
          hint: Text('Select a genra'),
          items: const [
            DropdownMenuItem(value: 'Fantasy Books', child: Text('Fantasy')),
            DropdownMenuItem(value: 'Romance Books', child: Text('Romance')),
            DropdownMenuItem(
              value: 'Historical Fiction Books',
              child: Text('Historical Fiction'),
            ),
            DropdownMenuItem(
              value: 'Science Fiction Books',
              child: Text('Science Fiction'),
            ),
            DropdownMenuItem(
              value: 'Non Fiction Books',
              child: Text('Non Fiction'),
            ),
            DropdownMenuItem(value: 'Horror Books', child: Text('Horror')),
            DropdownMenuItem(value: 'Kids Books', child: Text('Kids')),
            DropdownMenuItem(value: 'Comics Books', child: Text('Comics')),
          ],
        ),
      ),
    );
  }
}
