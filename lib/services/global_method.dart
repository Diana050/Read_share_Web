import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/widgets/text_widget.dart';

class GlobalMethods {
  static NavigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: TextWidget(
                text: 'Cancel',
                color: const Color.fromARGB(255, 130, 46, 163),
                textSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                fct();
              },
              child: TextWidget(text: 'OK', color: Colors.red, textSize: 18),
            ),
          ],
        );
      },
    );
  }
}
