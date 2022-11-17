import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  Dropdown(
      {super.key, required this.dropdownValue, required this.list, required this.icon});


  late String dropdownValue;
  List<String> list;
  late IconData icon;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.white,
      value: widget.dropdownValue,
      alignment: AlignmentDirectional.center,
      icon: Icon(
        widget.icon,
        color: Colors.grey,
      ),
      elevation: 0,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 18,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          widget.dropdownValue = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

