import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_share_disertatie_web/Models_and_Providers/product_provider.dart';
import 'package:read_share_disertatie_web/consts/theme_data.dart';
import 'package:read_share_disertatie_web/controllers/MenuController.dart';
import 'package:read_share_disertatie_web/providers/dark_theme_provider.dart';
import 'package:read_share_disertatie_web/screens/inner_screens/add_product.dart';
import 'package:read_share_disertatie_web/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Menucontroller()),
        //ChangeNotifierProvider<Menucontroller>(create: (_) => Menucontroller()),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
        // ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery',
            // theme: Styles.themeData(themeProvider.getDarkTheme, context),
            theme: Styles.themeData(false, context),
            darkTheme: Styles.themeData(true, context),
            themeMode:
                themeProvider.getDarkTheme ? ThemeMode.dark : ThemeMode.light,
            home: const MainScreen(),
            routes: {
              UploadProductForm.routeName:
                  (context) => const UploadProductForm(),
            },
          );
        },
      ),
    );
  }
}
