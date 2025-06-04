import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';

class OrdersWidgets extends StatefulWidget {
  const OrdersWidgets({Key? key}) : super(key: key);

  @override
  State<OrdersWidgets> createState() => _OrdersWidgetsState();
}

class _OrdersWidgetsState extends State<OrdersWidgets> {
  late String orderDateStr;
  @override
  void initState() {
    // var postDate = widget.orderDate.toDate();
    // orderDateStr = '${postDate.day}/${postDate.month}/${postDate.year}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    Size size = Utils(context).screenSize;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: size.width < 650 ? 3 : 1,
              child: Image.network(
                'https://cdn.dc5.ro/img-prod/4107534701-0-240.jpeg',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '2X for 30 days',
                    color: color,
                    textSize: 16,
                    isTitle: true,
                  ),
                  TextWidget(
                    text: 'id number',
                    color: color,
                    textSize: 14,
                    isTitle: false,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        TextWidget(
                          text: 'BY',
                          color: Color.fromARGB(255, 130, 46, 163),
                          textSize: 16,
                          isTitle: true,
                        ),
                        const SizedBox(width: 10),
                        TextWidget(
                          text: 'user 1',
                          color: color,
                          textSize: 14,
                          isTitle: true,
                        ),
                      ],
                    ),
                  ),
                  const Text('03/06/2025'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
