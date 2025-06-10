//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/services/global_method.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  bool _isLoading = false;
  String title = '';
  String author = '';
  String description = '';
  String productCat = '';
  String? imageUrl;
  String price = '0';
  bool isHot = false;

  //String? _email;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final DocumentSnapshot productsDoc =
          await FirebaseFirestore.instance
              .collection('products')
              .doc(widget.id)
              .get();
      if (!productsDoc.exists) {
        return;
      } else {
        // _email = userDoc.get('email');
        title = productsDoc.get('title');
        author = productsDoc.get('author');
        description = productsDoc.get('description');
        productCat = productsDoc.get('productCategoryName');
        imageUrl = productsDoc.get('imageUrl');
        price = productsDoc.get('price');
        isHot = productsDoc.get('isHot');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),

        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Image.network(
                          imageUrl == null
                              ? 'https://cdn.dc5.ro/img-prod/4107534701-0-240.jpeg'
                              : imageUrl!,
                          fit: BoxFit.fill,
                          height: size.width * 0.12,
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                child: Text('Edit'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  GlobalMethods.warningDialog(
                                    title: 'Do you want to delete this title?',
                                    subtitle: 'Press ok to confirm',
                                    fct: () async {
                                      await FirebaseFirestore.instance
                                          .collection('products')
                                          .doc(widget.id)
                                          .delete();
                                    },
                                    context: context,
                                  );
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                                value: 2,
                              ),
                            ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      TextWidget(text: author, color: color, textSize: 16),
                      const Spacer(),
                      TextWidget(
                        text: '$price days',
                        color: color,
                        textSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      TextWidget(
                        text: title,
                        color: color,
                        textSize: 24,
                        isTitle: true,
                      ),
                      SizedBox(width: 30),
                      isHot == true
                          ? Icon(CupertinoIcons.flame, color: Colors.redAccent)
                          : Text(''),
                    ],
                  ),
                  const SizedBox(height: 2),
                  TextWidget(
                    text: 'Description: $description',
                    color: color,
                    textSize: 16,
                    isTitle: false,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
