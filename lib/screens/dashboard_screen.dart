import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_share_disertatie_web/consts/constants.dart';
import 'package:read_share_disertatie_web/controllers/MenuController.dart';
import 'package:read_share_disertatie_web/responsive.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/grid_products.dart';
import 'package:read_share_disertatie_web/widgets/header.dart';
import 'package:read_share_disertatie_web/widgets/products_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<Menucontroller>().controlDashboardMenu();
              },
            ),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      //MyProductsHome(),
                      //SizedBox(hieght:defaultPaddind),
                      //OrdersScreen(),
                      Responsive(
                        mobile: ProductGridWidget(
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                          crossAxisCount: size.width < 700 ? 2 : 4,
                        ),
                        desktop: ProductGridWidget(
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension on MenuController {
  void controllerDashboardMenu() {}
}
