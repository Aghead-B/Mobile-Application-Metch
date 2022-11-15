import 'package:flutter/material.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class HomeTextButton extends StatelessWidget {
  const HomeTextButton(
      {super.key, required this.name, required this.icon, required this.page});

  final String name;
  final IconData icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return page;
            },
          ),
        );
      },
      //If you ever want to make a List item , then use this code
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12.5, 0, 12.5),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(name, style: headline2),
            ),
          ],
        ),
      ),
    );
  }
}
