import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:grocery_admin_panel/inner_screens/all_orders_screen.dart';
// import 'package:grocery_admin_panel/inner_screens/all_products.dart';
import 'package:provider/provider.dart';
import 'package:read_share_disertatie_web/providers/dark_theme_provider.dart';
import 'package:read_share_disertatie_web/screens/inner_screens/all_orders_screen.dart';
import 'package:read_share_disertatie_web/screens/inner_screens/all_products_screen.dart';
import 'package:read_share_disertatie_web/services/utils.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';

import '../screens/main_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);

    final color = Utils(context).color;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset("assets/images/booksLogo.png")),
          DrawerListTile(
            title: "Main",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
            icon: Icons.home_filled,
          ),
          DrawerListTile(
            title: "View all products",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllProductsScreen(),
                ),
              );
            },
            icon: Icons.store,
          ),
          DrawerListTile(
            title: "View all orders",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllOrdersScreen(),
                ),
              );
            },
            icon: IconlyBold.bag2,
          ),
          SwitchListTile(
            title: const Text('Theme'),
            secondary: Icon(
              themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            value: theme,
            onChanged: (value) {
              setState(() {
                themeState.setDarkTheme = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    //final theme = Utils(context).getTheme;
    final color = Colors.black;

    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(icon, size: 18),
      title: TextWidget(text: title, color: color, textSize: 20),
    );
  }
}
