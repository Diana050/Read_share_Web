// import 'package:flutter/material.dart';
// import 'package:read_share_disertatie_web/services/utils.dart';
// import 'package:read_share_disertatie_web/widgets/text_widget.dart';

// class OrdersWidgets extends StatefulWidget {
//   const OrdersWidgets({Key? key}) : super(key: key);

//   @override
//   State<OrdersWidgets> createState() => _OrdersWidgetsState();
// }

// class _OrdersWidgetsState extends State<OrdersWidgets> {
//   late String orderDateStr;
//   @override
//   void initState() {
//     // var postDate = widget.orderDate.toDate();
//     // orderDateStr = '${postDate.day}/${postDate.month}/${postDate.year}';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Utils(context).getTheme;
//     Color color = theme == true ? Colors.white : Colors.black;
//     Size size = Utils(context).screenSize;

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Material(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Theme.of(context).cardColor.withOpacity(0.4),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Flexible(
//               flex: size.width < 650 ? 3 : 1,
//               child: Image.network(
//                 'https://cdn.dc5.ro/img-prod/4107534701-0-240.jpeg',
//                 fit: BoxFit.fill,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               flex: 8,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   TextWidget(
//                     text: '2X for 30 days',
//                     color: color,
//                     textSize: 16,
//                     isTitle: true,
//                   ),
//                   TextWidget(
//                     text: 'id number',
//                     color: color,
//                     textSize: 14,
//                     isTitle: false,
//                   ),
//                   FittedBox(
//                     child: Row(
//                       children: [
//                         TextWidget(
//                           text: 'BY',
//                           color: Color.fromARGB(255, 130, 46, 163),
//                           textSize: 16,
//                           isTitle: true,
//                         ),
//                         const SizedBox(width: 10),
//                         TextWidget(
//                           text: 'user 1',
//                           color: color,
//                           textSize: 14,
//                           isTitle: true,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Text('03/06/2025'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_share_disertatie_web/Models_and_Providers/orders_model.dart';
import 'package:read_share_disertatie_web/Models_and_Providers/product_provider.dart';
import 'package:read_share_disertatie_web/services/utils.dart';

import 'text_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({
    Key? key,
    required this.price,
    // required this.totalPrice,
    required this.productId,
    required this.userId,
    required this.imageUrl,
    required this.userName,
    required this.quantity,
    required this.orderDate,
  }) : super(key: key);
  final double price;
  // final double totalPrice;
  final String productId, userId, imageUrl, userName;
  final int quantity;
  final Timestamp orderDate;
  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  late String orderDateStr;
  @override
  void initState() {
    var postDate = widget.orderDate.toDate();
    orderDateStr = '${postDate.day}/${postDate.month}/${postDate.year}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    Size size = Utils(context).screenSize;

    // final OrdersModel = Provider.of<OrderModel>(context);
    // final productProvider = Provider.of<ProductsProvider>(context);
    // final getCurrProduct = productProvider.findProductById(
    //   OrdersModel.productId,
    // // );
    // final productProvider = Provider.of<ProductsProvider>(context);

    // final getCurrProduct = productProvider.findProductById(widget.productId);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: size.width < 650 ? 3 : 1,
                child: Image.network(
                  widget.imageUrl,

                  fit: BoxFit.fill,
                  // height: screenWidth * 0.15,
                  // width: screenWidth * 0.15,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // TextWidget(
                    //   text: getCurrProduct.title,
                    //   color: color,
                    //   textSize: 16,
                    //   isTitle: true,
                    // ),
                    TextWidget(
                      text: 'Title id: ${widget.productId}',
                      color: color,
                      textSize: 16,
                      isTitle: false,
                    ),
                    const SizedBox(height: 15),
                    TextWidget(
                      text: 'Borrowed for ${widget.price.toStringAsFixed(0)}',
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          TextWidget(
                            text: 'By',
                            color: Colors.blue,
                            textSize: 16,
                            isTitle: true,
                          ),
                          Text('  ${widget.userName}'),
                        ],
                      ),
                    ),
                    Text(orderDateStr),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
