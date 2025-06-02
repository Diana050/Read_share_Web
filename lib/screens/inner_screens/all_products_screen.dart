import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_share_disertatie_web/controllers/MenuController.dart';
import 'package:read_share_disertatie_web/responsive.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/grid_products.dart';
//import 'package:read_share_disertatie_web/screens/dashboard_screen.dart';
import 'package:read_share_disertatie_web/widgets/header.dart';
import 'package:read_share_disertatie_web/widgets/side_menu.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    return Scaffold(
      key: context.read<Menucontroller>().getgridscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      fct: () {
                        context.read<Menucontroller>().controlProductsMenu();
                      },
                    ),
                    Responsive(
                      mobile: ProductGridWidget(
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        crossAxisCount: size.width < 700 ? 2 : 4,
                        isInMai: false,
                      ),
                      desktop: ProductGridWidget(
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        isInMai: false,
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
    ;
  }
}
