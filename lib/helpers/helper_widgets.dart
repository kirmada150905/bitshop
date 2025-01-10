import 'package:flutter/material.dart';

class HorizontalOrLine extends StatelessWidget {
  final String label;
  final double height;

  const HorizontalOrLine({
    required this.label,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Colors.black,
              thickness: height,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              thickness: height,
            ),
          ),
        ),
      ],
    );
  }
}
