import 'package:flutter/material.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key, required this.name, required this.icon});

  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                name,
                style: headline2
              ),
            ),
          ],
        ),
      ),
    );
  }
}