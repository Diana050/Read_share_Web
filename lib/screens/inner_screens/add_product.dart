import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:read_share_disertatie_web/consts/constants.dart';
import 'package:read_share_disertatie_web/controllers/MenuController.dart';
import 'package:read_share_disertatie_web/responsive.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/buttons.dart';
import 'package:read_share_disertatie_web/widgets/header.dart';
import 'package:read_share_disertatie_web/widgets/side_menu.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';
  const UploadProductForm({Key? key}) : super(key: key);

  @override
  State<UploadProductForm> createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController,
      _authorController,
      _priceController;
  // int _groupValue = 1;
  // bool isPiece = false;
  // File? _pickedImage;
  // Uint8List webImage = Uint8List(8);
  @override
  void initState() {
    _priceController = TextEditingController();
    _titleController = TextEditingController();
    _authorController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _priceController.dispose();
      _titleController.dispose();
      _authorController.dispose();
    }
    super.dispose();
  }

  void _uploadForm() async {
    final isvalid = _formKey.currentState!.validate();
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) const Expanded(child: SideMenu()),
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
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: 'Number of days',
                                        color: color,
                                        textSize: 6,
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
                                        textSize: 6,
                                        isTitle: true,
                                      ),
                                      const SizedBox(height: 10),
                                      //drop down menu
                                    ],
                                  ),
                                ),
                              ),
                              //image to be picked
                              Expanded(
                                flex: 1,
                                child: FittedBox(
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: TextWidget(
                                          text: 'Clear',
                                          color: Colors.red,
                                          textSize: 5,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: TextWidget(
                                          text: 'Update Image',
                                          color: Colors.lightBlue,
                                          textSize: 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonsWidget(
                                  onPressed: () {},
                                  text: 'Clear Form',
                                  icon: IconlyBold.danger,
                                  backgroundColor: Colors.red.shade300,
                                ),
                                ButtonsWidget(
                                  onPressed: () {},
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
    );
  }
}
