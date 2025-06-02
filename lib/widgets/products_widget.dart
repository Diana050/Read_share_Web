import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
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
                        'https://cdn.dc5.ro/img-prod/4107534701-0-240.jpeg',
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
                              onTap: () {},
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextWidget(
                      text: 'Rebecca Yarros',
                      color: color,
                      textSize: 16,
                    ),
                    const Spacer(),
                    TextWidget(text: '30 days', color: color, textSize: 18),
                  ],
                ),
                const SizedBox(height: 2),
                TextWidget(
                  text: 'Onyx storm',
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
