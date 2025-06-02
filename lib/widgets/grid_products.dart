import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/consts/constants.dart';
import 'package:read_share_disertatie_web/widgets/products_widget.dart';

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
    return GridView.builder(
      itemCount: isInMai ? 4 : 8,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) {
        return ProductsWidget();
      },
    );
  }
}
