// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:read_share_disertatie/models/orders_model.dart';

// class OrdersProvider with ChangeNotifier {
//   List<OrderModel> _orders = [];
//   List<OrderModel> get getOrders {
//     return _orders;
//   }

//   Future<void> fetchOrder() async {
//     await FirebaseFirestore.instance.collection('orders').get().then((
//       QuerySnapshot ordersSnapshot,
//     ) {
//       _orders = [];
//       ordersSnapshot.docs.forEach((element) {
//         _orders.insert(
//           0,
//           OrderModel(
//             orderId: element.get('orderId'),
//             userId: element.get('userId'),
//             productId: element.get('productId'),
//             userName: element.get('userName'),
//             price: element.get('price').toString(),
//             imageUrl: element.get('imageUrl'),
//             quantity: element.get('quantity').toString(),
//             orderDate: element.get('orderDate'),
//           ),
//         );
//       });
//     });
//   }

//   notifyListeners();
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:read_share_disertatie_web/Models_and_Providers/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    await FirebaseFirestore.instance.collection('orders').get().then((
      QuerySnapshot ordersSnapshot,
    ) {
      _orders = [];
      // _orders.clear();
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: element.get('productId'),
            userName: element.get('userName'),
            price: element.get('price').toString(),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantity').toString(),
            orderDate: element.get('orderDate'),
          ),
        );
      });
    });
    notifyListeners();
  }
}
