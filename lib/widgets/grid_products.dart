import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/consts/constants.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/products_widget.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.isInMai = true,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMai;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            return snapshot.data!.docs.length == 0
                ? Center(
                  child: TextWidget(
                    text: 'You did not add any titles yet',
                    color: color,
                    textSize: 24,
                    isTitle: true,
                  ),
                )
                : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      isInMai && snapshot.data!.docs.length > 4
                          ? 4
                          : snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                  ),
                  itemBuilder: (context, index) {
                    return ProductsWidget(id: snapshot.data!.docs[index]['id']);
                  },
                );
          } else {
            return const Center(child: Text('Your store is empty'));
          }
        }
        return const Center(
          child: Text('Something went wrong', style: TextStyle(fontSize: 30)),
        );
        // return GridView.builder(
        //   itemCount: isInMai ? 4 : 8,
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: crossAxisCount,
        //     childAspectRatio: childAspectRatio,
        //     crossAxisSpacing: defaultPadding,
        //     mainAxisSpacing: defaultPadding,
        //   ),
        //   itemBuilder: (context, index) {
        //     return ProductsWidget();
        //   },
        // );
      },
    );
  }
}
