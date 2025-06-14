import 'package:flutter/material.dart';
import 'package:read_share_disertatie_web/consts/constants.dart';
import 'package:read_share_disertatie_web/responsive.dart';
import 'package:read_share_disertatie_web/services/utils.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.fct,
    required this.title,
    this.showText = true,
  }) : super(key: key);
  final Function fct;
  final String title;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;

    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: () {
              fct();
            },
            icon: const Icon(Icons.menu),
          ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        !showText
            ? Container()
            : Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2,
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 130, 46, 163),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(Icons.search, size: 25),
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
