import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class StarRatingDropdown extends StatefulWidget {
  StarRatingDropdown(
      {super.key, required this.text, required this.dropdownValue, required this.list, required this.icon, required this.onChanged, required this.limitValue});


  late String dropdownValue;
  List<String> list;
  late IconData icon;
  late String limitValue;
  final String text;
  final ValueChanged<String> onChanged;


  @override
  State<StarRatingDropdown> createState() => _StarRatingDropdownState();
}

class _StarRatingDropdownState extends State<StarRatingDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          widget.text,
          style: headline2,
        ),
        Container(
          alignment: AlignmentDirectional.center,
          margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          width: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child:  DropdownButton<String>(
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
              switch(widget.text) {
                case "Minimum": {
                  if (int.parse(value!) <= int.parse(widget.limitValue)) {
                    setState(() {
                      print("Min: $value");
                      widget.dropdownValue = value;
                    });
                    widget.onChanged(value);
                  }
                }
                break;

                case "Maximum": {
                  if (int.parse(value!) >= int.parse(widget.limitValue)) {
                    setState(() {
                      print("Max: $value");
                      widget.dropdownValue = value;
                    });
                    widget.onChanged(value);
                  }
                }
                break;

                default: {
                  setState(() {
                    widget.dropdownValue = value!;
                  });
                  widget.onChanged(value!);
                }
                break;
              }
            },
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        RatingBarIndicator(
          rating: double.parse(widget.dropdownValue),
          itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Color.fromRGBO(242, 139, 32, 1.000),
          ),
          itemCount: 5,
          itemSize: 42.0,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}

